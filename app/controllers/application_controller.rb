class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :middle_name, :last_name, :country,
               :phone_number, :email, :password, :terms)
    end
    devise_parameter_sanitizer.permit(:invite,
                                      keys: %i[first_name middle_name last_name phone_number country email])
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :middle_name, :last_name, :country,
               :phone_number, :email, :avatar, :password, :password_confirmation, :current_password)
    end
  end

  def authenticate_inviter!
    is_admin?
  end

  def is_admin?
    redirect_to new_user_session_path if current_user.nil?
    redirect_to root_path if current_user.present? && !current_user.admin?
  end

  def is_user?
    redirect_to new_user_session_path if current_user.nil?
    redirect_to admin_root_path if current_user.present? && current_user.admin?
  end
end
