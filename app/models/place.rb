class Place < ApplicationRecord
  has_many :tours, dependent: :destroy
end
