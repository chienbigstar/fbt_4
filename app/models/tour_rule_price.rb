class TourRulePrice < ApplicationRecord
  belongs_to :tour_rule
  belongs_to :tour
end
