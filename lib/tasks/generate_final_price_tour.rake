namespace :db do
  task generate_final_price_tour: :environment do
    TourRule.all.each{|tour_rule| tour_rule.update_price}
    TourRule.generate_final_price
  end
end
