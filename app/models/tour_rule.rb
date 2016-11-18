class TourRule < ApplicationRecord
  has_many :conditions, dependent: :destroy
  accepts_nested_attributes_for :conditions, allow_destroy: true,
    reject_if: lambda {|rule| rule[:valued].blank?}

  validates :name, presence: true, length: {maximum: 30}
  validates :amount, presence: true, format: {with: /\A[1-9]/i}
  validates :type_cal, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
  validates :conditions, presence: true
  validate :range_day, if: Proc.new {start_day && end_day}

  enum type_cal: [:fixed, :percent]
  enum typed: [:price_less, :price_more, :place]

  def range_day
    errors.add :base, I18n.t("tour_rule.range_day") if start_day > end_day
  end
end
