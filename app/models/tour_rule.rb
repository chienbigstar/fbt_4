class TourRule < ApplicationRecord
  has_many :conditions, dependent: :destroy
  accepts_nested_attributes_for :conditions, allow_destroy: true,
    reject_if: lambda {|rule| rule[:valued].blank?}
  has_many :tour_rule_prices, dependent: :destroy
  accepts_nested_attributes_for :tour_rule_prices

  validates :name, presence: true, length: {maximum: 30}
  validates :amount, presence: true, format: {with: /\A[1-9]/i}
  validates :type_cal, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
  validates :conditions, presence: true
  validate :range_day, if: Proc.new {start_day && end_day}

  before_create :generate_price
  before_update :update_price

  enum type_cal: [:fixed, :percent]
  enum typed: [:price_less, :price_more, :place]

  def range_day
    errors.add :base, I18n.t("tour_rule.range_day") if start_day >= end_day
  end

  def generate_price
    current_time = DateTime.now
    if start_day <= current_time && current_time < end_day
      tours = get_list_tour
      self.tour_rule_prices_attributes = tours.collect{|tour| change_price(tour)}
    end
  end

  def update_price
    self.tour_rule_prices.each{|t| t.destroy}
    generate_price
  end

  private
  def get_list_tour
    tours = Tour
    conditions.each{|c|
      case c[:typed]
        when "price_less"
          tours = tours.price_less c[:valued]
        when "price_more"
          tours = tours.price_more c[:valued]
        when "place"
          tours = tours.place c[:valued]
      end
    }
    tours
  end

  def change_price tour
    result = {tour_id: tour.id, day: DateTime.now.strftime('%Y/%m/%d')}
    if type_cal == "fixed"
      result[:price] = tour.price.to_i - amount.to_i
    elsif type_cal == "percent"
      result[:price] = tour.price.to_i * (100 - amount.to_i) / 100
    end
    result
  end
end
