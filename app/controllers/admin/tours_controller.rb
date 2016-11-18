class Admin::ToursController < ApplicationController
  load_and_authorize_resource find_by: :slug

  before_action :authenticate_user!
  before_action :load_supports, except: [:index, :show, :destroy]

  def index
    @tours = Tour.all.page(params[:page]).per Settings.tour
    @time = params[:time]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
  end

  def create
    if @tour.save
      redirect_to admin_tour_path @tour
      flash.now[:success] = t "controller.create_tour"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tour.update_attributes tour_params
      flash.now[:success] = t "controller.edit_tour"
      redirect_to admin_tour_path @tour
    else
      render :edit
    end
  end

  def destroy
    if @tour.destroy
      flash.now[:success] = t "controller.delete_success"
      redirect_to admin_tours_path
    else
      redirect_to admin_tours_path
      flash.now[:success] = t "controller.delete_fail"
    end
  end

  private
  def tour_params
    params.require(:tour).permit :name, :start_day, :description,
      :price, :schedule, :is_active, :image, :place_id,
      :discount_id, :tag_list, :time_tour
  end

  def load_supports
    @admin_supports = Supports::AdminTour.new
  end
end
