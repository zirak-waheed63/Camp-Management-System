class PagesController < ApplicationController
  before_action :not_admin?

  def introduction
    redirect_to dashboard_path if current_user.camp_application.present?
    @camp = Camp.find_by(status: true)
    flash[:alert] = 'No active camp available currently' if @camp.blank?
  end

  def dashboard
    @camp_application = current_user.camp_application
    if @camp_application.blank?
      redirect_to root_path
      return
    end

    @camp = @camp_application.camp
    @camp_application.update_progress
    @camp_application.update_status
    @progress = @camp_application.progress
  end

  private

  def not_admin?
    redirect_to admin_root_path if current_user.admin?
  end
end
