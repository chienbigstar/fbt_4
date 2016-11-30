class Admin::FinalPricesController < ApplicationController
  def index
    if TourRule.generate_final_price
      flash[:success] = t "tour_rule.apply_success"
    else
      flash[:success] = t "tour_rule.apply_not_success"
    end
    redirect_to admin_tour_rules_path
  end
end
