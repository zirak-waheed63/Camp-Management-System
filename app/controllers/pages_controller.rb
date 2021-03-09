class PagesController < ApplicationController
  before_action :is_user?
  def home
    @camps = Camp.all.where(status: true)
  end
  def dashboard
    @applications = CampApplication.all.where(user_id: current_user)
  end
end