class BaseController < ApplicationController
  before_action :is_admin?

  private
  
  def is_admin?
    redirect_to admin_root_path if current_user.admin?
  end
end