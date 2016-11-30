class TourRule < ApplicationRecord
  has_many :tour_rule_prices, dependent: :destroy
  has_many :conditions, dependent: :destroy
  accepts_nested_attributes_for :conditions, allow_destroy: true

  validates :name, presence: true, length: {maximum: 30}
  validates :amount, presence: true, format: {with: /\A[1-9]/i}
  validates :type_cal, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
  validates :conditions, presence: true
  validate :range_day, if: Proc.new {start_day && end_day}

  after_create :generate_price
  after_update :update_price

  enum type_cal: [:fixed, :percent, :set_as]

  def generate_price
    current_time = DateTime.now
    if start_day <= current_time && current_time < end_day
      tours = get_list_tour
      params = tours.collect{|tour| params_tour_price(tour)}
      self.tour_rule_prices.create params
    end
  end

  def update_price
    self.tour_rule_prices.each{|t| t.destroy}
    generate_price
  end

  private
  def range_day
    errors.add :base, I18n.t("tour_rule.range_day") if start_day > end_day
  end

  def get_list_tour
    tours = Tour
    conditions.each do |condition|
      tours = tours.send condition[:condition_type], condition[:condition_value]
    end
    tours
  end

  def params_tour_price tour
    result = {tour_id: tour.id, day: DateTime.now.strftime(Settings.format_date)}
    if fixed?
      result[:price] = tour.price.to_i - amount.to_i
    elsif percent?
      result[:price] = tour.price.to_i * (100 - amount.to_i) / 100
    elsif set_as?
      result[:price] = tour.price.to_i
    end
    result
  end

  class << self
    def generate_final_price
      TourFinalPrice.delete_all
      min_rule_price = TourRulePrice.select("id, tour_id, MIN(price) as price").group :tour_id
      params = []
      min_rule_price.to_a.each_with_index{|value, index|
        param = value.attributes
        param[:tour_rule_price_id] = param.delete "id"
        params.push(param)
      }
      TourFinalPrice.create params
    end
  end
end
