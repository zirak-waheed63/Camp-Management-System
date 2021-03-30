class PagesController < BaseController
  def introduction
    redirect_to dashboard_path if current_user.camp_application.present?
    @camp = Camp.find_by(status: true)
    flash[:alert] = 'No active camp available currently' if @camp.blank?
  end

  def dashboard
    @camp_application = current_user.camp_application
    return redirect_to root_path if @camp_application.blank?
    @camp = @camp_application.camp
    @progress = @camp_application.progress
  end
end
