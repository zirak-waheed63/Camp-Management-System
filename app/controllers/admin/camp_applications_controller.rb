class Admin::CampApplicationsController < Wicked::WizardController
	before_action :set_application, except: :index
	before_action :set_progress, only: [:show]
	before_action :is_admin?
  
  steps :personal_information, :step_two, :step_three, :step_four, :step_five, :step_six, :step_seven,
        :step_eight, :step_nine, :step_ten
	
  def show
    render_wizard
  end

  def update
    @camp_application.update_attributes(application_params)
    @camp_application.update_progress
    @camp_application.update_status

    render_wizard @camp_application
  end

	def index
		@camp_applications = CampApplication.all
	end

	def view
		redirect_to admin_camp_applications_path, alert: 'Application is still in progress' unless @camp_application.status == 'active'
	end

	def destroy
		@camp_application.destroy
		redirect_to admin_camp_applications_path, notice: 'Application has deleted successfully'
	end

	def finish_wizard_path
    admin_camp_applications_path
  end

	private

	def set_application
		@camp_application = CampApplication.find(params[:application_id])
	end

	def set_progress
    @progress = if wizard_steps.any? && wizard_steps.index(step).present?
                  ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
                else
                  0
                end
  end

  def application_params
    params.require(:camp_application).permit(:image, :name, :email, :gender, :step_two, :step_three, :step_four,
                                             :step_five, :step_six, :step_seven, :step_eight, :step_nine, :step_ten,
                                             :camp_id)
  end

end
