class Category < ApplicationRecord
  has_many :tours_categories, dependent: :destroy
  has_many :tours, through: :tours_categories
end
