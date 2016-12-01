class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html{
        flash[:danger] = t "controller.permission"
        redirect_to root_path
      }
      format.js{render "shared/must_sign_in.js.erb"}
    end
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = t "application.nil"
    redirect_to root_url
  end
  
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :email,
      :password, :password_confirmation]
    devise_parameter_sanitizer.permit :account_update, keys: [:name, :email,
      :password, :password_confirmation]
  end

  def current_ability
    controller_name_segments = params[:controller].split("/")
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join("/").camelize
    Ability.new current_user, controller_namespace
  end

end
