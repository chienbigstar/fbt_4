class Tour < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  acts_as_taggable
  ratyrate_rateable :quality, :food, :news, :place

  has_attached_file :image, styles:{medium: "300x300>", thumb: "100x100>"},
    default_url: Settings.default_image_tour
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :tours_categories, dependent: :destroy
  has_many :categories, through: :tours_categories
  has_many :tours_discounts, dependent: :destroy
  has_many :discounts, through: :tours_discounts
  has_one :tour_final_price, dependent: :destroy

  belongs_to :place

  enum is_active: [:publish, :expire]

  validates :name, presence: true, length: {minimum: 5, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 500}
  validates :schedule, presence: true, length: {minimum: 100, maximum: 60000}
  validates :is_active, presence: true
  validates :time_tour, presence: true, numericality:
    {greater_than_or_equal_to: 1, less_than_or_equal_to: 30}
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0,
    only_integer: true}, length: {minimum: 1, maximum: 10}
  validates :place, presence: true
  validates_attachment :image, content_type:
    {content_type: ["image/jpeg", "image/gif", "image/png"]}
  validate :check_start_time, on: [:create]

  scope :price_less, -> price {where("price < ?", price)}
  scope :price_more, -> price {where("price > ?", price)}
  scope :place, -> ids {where("place_id in (?)", ids)}
  scope :tour, -> ids {where("id in (?)", ids)}

  def check_start_time
    if self.start_day < DateTime.now
      errors.add :base, I18n.t("model.year")
    end
  end

  private
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
