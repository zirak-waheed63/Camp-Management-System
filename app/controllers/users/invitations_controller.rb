class Users::InvitationsController < Devise::InvitationsController
  
  def authenticate_inviter!
    redirect_to root_path unless current_user.admin.present?
  end

  def invite_params
    devise_parameter_sanitizer.permit(:user, keys: %i[first_name middle_name last_name phone_number country email])
    devise_parameter_sanitizer.sanitize(:user)
  end
end
