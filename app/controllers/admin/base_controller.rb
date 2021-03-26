class Admin::BaseController < ApplicationController
  before_action :is_admin?

  private

  def is_admin?
    redirect_to root_path if current_user.present? && !current_user.admin?
  end
end
