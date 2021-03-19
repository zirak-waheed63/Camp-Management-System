class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :middle_name, :last_name, :country,
               :phone_number, :email, :password, :password_confirmation, :terms)
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :middle_name, :last_name, :country,
               :phone_number, :email, :avatar, :password, :password_confirmation, :current_password)
    end
  end

end
