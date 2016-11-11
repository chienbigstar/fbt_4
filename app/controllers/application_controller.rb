class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = t "application.nil"
    redirect_to root_url
   end

  private
  def find_tour
    @tour = Tour.find_by_id params[:id]
    unless @tour
      flash[:danger] = t "tours.not_found"
      redirect_to root_path
    end
  end
end
