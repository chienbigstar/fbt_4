class TourFinalPrice < ApplicationRecord
  belongs_to :tour
  belongs_to :tour_rule_price
end
