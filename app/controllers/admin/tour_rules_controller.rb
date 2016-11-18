class Admin::TourRulesController < ApplicationController
  load_and_authorize_resource
  before_action :support_tour_rule

  def index
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
  end

  def create
    @tour_rule = TourRule.new tour_rule_params
    if @tour_rule.save
      flash[:success] = t "tour_rule.create_scucess"
      redirect_to admin_tour_rules_path
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js {render file: "admin/tour_rules/new.js.erb"}
    end
  end

  def update
    if @tour_rule.update_attributes tour_rule_params
      flash[:success] = t "tour_rule.create_scucess"
      redirect_to admin_tour_rules_path
    else
      render :edit
    end
  end

  def destroy
    if @tour_rule.destroy
      flash[:success] = t "tour_rule.destroy_success"
      redirect_to admin_tour_rules_path
    end
  end

  private
  def tour_rule_params
     params.require(:tour_rule).permit :name, :amount, :type_cal, :start_day,
       :end_day, conditions_attributes: [:id, :typed, :valued, :_destroy]
  end

  def support_tour_rule
    @support = Supports::TourRule.new
  end
end
