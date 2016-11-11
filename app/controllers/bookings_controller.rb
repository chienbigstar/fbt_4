class BookingsController < ApplicationController
  before_action :find_tour, only: :new

  def new
    @book = Booking.new
    store_location_for(:tour, tour_path(@tour))
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @params = booking_params
    apply_token_booking_param
    apply_price_param
    apply_discount_price_param
    if(@book = Booking.create @params)
      respond_to do |format|
        format.js
      end
    end
  end
  private
  def booking_params
    params.require(:booking).permit :user_id, :tour_id, :numbermember
  end

  def apply_price_param
    tour = Tour.find_by_id @params[:tour_id]
    @params[:totalmoney] = @params[:numbermember] * tour.price
    @params[:totalmoney] = @params[:numbermember] * tour.price
  end

  def apply_discount_price_param
  end

  def apply_token_booking_param
    @params[:user_id] = @params[:user_id].to_i
    @params[:tour_id] = @params[:tour_id].to_i
    @params[:numbermember] = @params[:user_id].to_i
    @params[:payment_token] = Booking.new_token
  end
end
