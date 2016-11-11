class Review < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy, as: :likeable

  belongs_to :tour
  belongs_to :user
end
