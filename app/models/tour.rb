class Tour < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :tours_categories, dependent: :destroy
  has_many :categories, through: :tours_categories
  has_many :tours_discounts, dependent: :destroy
  has_many :discounts, through: :tours_discounts

  belongs_to :place
end
