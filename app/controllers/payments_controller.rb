require "net/http"
require "net/https"

class PaymentsController < ApplicationController
  authorize_resource class: false
  def new
    if @book = Booking.find_by(id: params[:id])
      @book.public_token = Booking.new_token
      data = data_payment @book
      respond = get_api_call Settings.order_bank_url, data

      @status = Settings.payment.system_error unless respond
    else
      @status = Settings.payment.booking_not_found
    end
  end

  def update
    book = Booking.find_by payment_token: params[:token]
    book.update_attribute :is_pay, true if book
  end

  private
  def get_api_call url, params
    uri = URI url
    uri.query = URI.encode_www_form params
    res = Net::HTTP.get_response uri
    res.is_a?(Net::HTTPSuccess) ? res.body : false
  end

  def data_payment book
    { 
      authen_token: Settings.bank_token,
      money: book.total_money,
      public_token: book.public_token,
      private_token: book.payment_token
    }
  end
end
