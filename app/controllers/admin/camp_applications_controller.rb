class Admin::CampApplicationsController < Admin::BaseController
  include Wicked::Wizard
  before_action :set_application, except: :index
  
  steps :personal_information, :step_two, :step_three, :step_four, :step_five, :step_six, :step_seven,
        :step_eight, :step_nine, :step_ten
  
  def show
    render_wizard
  end

  def update
    if @camp_application.update(application_params)
      @camp_application.complete_step(step)
    end
    
    render_wizard @camp_application
  end

  def index
    @camp_applications = CampApplication.all
  end

  def view
    redirect_to admin_camp_applications_path, alert: 'Application is still in progress' unless @camp_application.status == 'active'
  end

  def edit; end

  def destroy
    @camp_application.destroy
    redirect_to admin_camp_applications_path, notice: 'Application has deleted successfully'
  end

  def finish_wizard_path
    edit_admin_camp_application_path
  end

  private

  def set_application
    @camp_application = CampApplication.find(params[:application_id])
  end

  def application_params
    params.require(:camp_application).permit(:image, :name, :email, :gender, :step_two, :step_three, :step_four,
                                             :step_five, :step_six, :step_seven, :step_eight, :step_nine, :step_ten,
                                             :camp_id)
  end
end
