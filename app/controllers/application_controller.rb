class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def find_tour
    @tour = Tour.find_by_id params[:id]
    unless @tour
      flash[:danger] = t "tours.not_found"
      redirect_to root_path
    end
  end
end
