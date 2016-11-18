class Admin::PlacesController < ApplicationController
  load_and_authorize_resource

  def index
    @places = Place.all.order(created_at: :desc).page params[:page]
    @time = params[:time]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
  end
  
  def create
    if @place.save
      flash[:success] = t "controllers.admin.places.flash.create_place"
      redirect_to admin_places_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @place.update_attributes place_params
      flash[:success] = t "controllers.admin.places.flash.edit_place"
      redirect_to admin_places_path
    else
      render :edit
    end
  end

  def destroy
    if @place.destroy
      flash[:success] = t "controllers.admin.places.flash.delete_place"
    else
      flash[:success] = t "controllers.admin.places.flash.not_delete"
    end
    redirect_to admin_places_path
  end

  private
  def place_params
    params.require(:place).permit :name
  end
end
