class PaymentController < ApplicationController
  def new
    @book = Booking.find_by_id params[:id]
    respond_to do |format|
      format.js
    end
  end
end
