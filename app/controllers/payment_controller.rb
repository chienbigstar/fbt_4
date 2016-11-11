require 'net/http'
require 'net/https'

class PaymentController < ApplicationController
  def new
    @book = Booking.find_by_id params[:id]
    @status_payment = false
    unless @book.blank?
      @public_token = Booking.new_token
      @status_payment = get_api_call(Settings.order_bank_url, data_payment)
    end

    respond_to do |format|
      format.js
    end
  end

  private
  def get_api_call(url, params)
    uri = URI(url)
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    res.is_a?(Net::HTTPSuccess) ? res.body : false
  end

  def data_payment
    {
      authen_token: Settings.bank_token,
      money: @book.totalmoney,
      public_token: @public_token,
      private_token: @book.payment_token
    }
  end
end
