class BookingsController < ApplicationController
  load_and_authorize_resource
  before_action :find_tour, only: :new

  def new
    @book = Booking.new
  end

  def create
    @book = current_user.bookings.new booking_params
    if @book.save
      @book.create_activity :create, owner: current_user
    else
      @status = Settings.booking.error
    end
  end

  private
  def booking_params
    params.require(:booking).permit :tour_id, :number_member
  end

  def find_tour
    @tour = Tour.find_by id: params[:id]
    unless @tour
      flash[:danger] = t "tours.not_found"
      redirect_to root_path
    end
  end
end
