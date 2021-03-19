class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protected

  def is_user?
    redirect_to admin_root_path if current_user.present? && current_user.admin?
  end
end
