class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :middle_name, :last_name, :country, :phone_number, :email, :password, :terms) }
    devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :middle_name, :last_name, :phone_number, :country, :email])
    #devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :is_female, :date_of_birth) }
  end

  def authenticate_inviter!
    is_admin?
  end
  def is_admin?
    if current_user.nil? || !current_user.admin?
      redirect_to root_path
    end
  end
end
