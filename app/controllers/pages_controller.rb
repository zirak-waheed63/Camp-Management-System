class PagesController < ApplicationController
  before_action :is_user?
  def dashboard
    @camp_application = CampApplication.find_by(user_id: current_user.id)
    if @camp_application.nil?
      @camp_application = CampApplication.create(user: current_user, camp: Camp.find_by(status: true))
    end
     @camp = @camp_application.camp
     @camp_application.update_progress
     @camp_application.update_status
     @progress = @camp_application.progress
  end
end
