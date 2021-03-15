class PagesController < ApplicationController
  before_action :is_user?
  def dashboard
    @camp_application = CampApplication.find_by(user_id: current_user.id)
    
    if @camp_application.nil?
    	camp = Camp.find_by(status: true)
    	flash[:alert] = "No active camp available currently" if camp.nil?
      @camp_application = CampApplication.create(user: current_user, camp: camp)
    end

     @camp = @camp_application.camp
     @camp_application.update_progress
     @camp_application.update_status
     @progress = @camp_application.progress
  end
end
