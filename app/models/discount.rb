class Discount < ApplicationRecord
  has_many :bookings
  has_many :tours_discounts, dependent: :destroy
  has_many :tours, through: :tours_discounts
end
