class BaseController < ApplicationController
  before_action :authenticate_admin

  private

  def authenticate_admin
    redirect_to admin_root_path if current_user.admin?
  end
end
