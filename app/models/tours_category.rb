class ToursCategory < ApplicationRecord
  belongs_to :tour
  belongs_to :category
end
