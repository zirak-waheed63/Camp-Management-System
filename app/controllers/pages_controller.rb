class PagesController < ApplicationController
  before_action :is_user?
  def dashboard
    @camp_application = CampApplication.find_by(user_id: current_user.id)
    if @camp_application.nil?
      @camp_application = CampApplication.create(user: current_user, camp: Camp.find_by(status: true))
    end
     @camp = @camp_application.camp
     @progress = calculate_progress
  end

  private

  def calculate_progress
  	case @camp_application.status
  	when 'personal_information'
  		0
  	when 'step_two'
		10
	when 'step_three'
		20
	when 'step_four'
		30
	when 'step_five'
		40
	when 'step_six'
		50
	when 'step_seven'
		60
	when 'step_eight'
		70
	when 'step_nine'
		80
	when 'step_ten'
		90
	when 'active'
		100
	else
		0
  	end
	  		
  end
end
