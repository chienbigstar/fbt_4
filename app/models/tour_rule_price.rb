class TourRulePrice < ApplicationRecord
  belongs_to :tour_rule
  belongs_to :tour
  has_one :tour_final_price, dependent: :destroy
end
