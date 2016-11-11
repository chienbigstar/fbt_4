class ToursDiscount < ApplicationRecord
  belongs_to :tour
  belongs_to :discount
end
