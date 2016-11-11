class Category < ApplicationRecord
  has_many :tours_categories, dependent: :destroy
  has_many :tours, through: :tours_categories
  validates :name, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}
end
