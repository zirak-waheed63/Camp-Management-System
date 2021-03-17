class CampApplicationsController < Wicked::WizardController
  before_action :set_progress, only: [:show]
  before_action :is_user?
  before_action :set_application, except: :create
  before_action :active?, except: [:view_application, :create]
  before_action :validate_dates, only: [:show, :update]

  steps :personal_information, :step_two, :step_three, :step_four, :step_five, :step_six, :step_seven,
        :step_eight, :step_nine, :step_ten

  def create
    camp = Camp.find_by(status: true)
    if camp.nil?
      redirect_to root_path, alert: 'No active camp available currently' 
    elsif Date.today > camp.end_date
      redirect_to root_path, alert: 'Camp has ended. Please participate in next camp'
    else
      @camp_application = CampApplication.create(user: current_user, camp: camp)
      redirect_to dashboard_path
    end
    return
  end

  def show
    if current_step?(:personal_information)
      if @camp_application.name.nil?
        @camp_application.name = "#{current_user.first_name} #{current_user.middle_name} #{current_user.last_name}"
      end
      @camp_application.email = current_user.email if @camp_application.email.nil?
      if !@camp_application.image.attached? && current_user.avatar.attached?
        @camp_application.image.attach(current_user.avatar.blob)
      end
    end
    render_wizard
  end

  def update
    @camp_application.update_attributes(application_params)
    @camp_application.update_progress
    @camp_application.update_status

    if @camp_application.progress == 100
      flash[:notice] = 'Application submitted successfully'
    else
      jump_to(@camp_application.status.to_sym)
    end

    render_wizard @camp_application
  end

  def finish_wizard_path
    root_path
  end

  def view_application; end

  private

  def set_progress
    @progress = if wizard_steps.any? && wizard_steps.index(step).present?
                  ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
                else
                  0
                end
  end

  def set_application
    @camp_application = current_user.camp_application
    redirect_to root_path, alert: 'No application found.' if @camp_application.nil?
  end

  def validate_dates
    if Date.today > @camp_application.camp.end_date
      flash[:alert] = 'Camp has ended. Please participate in next camp'
      redirect_to root_path
    end
  end

  def application_params
    params.require(:camp_application).permit(:image, :name, :email, :gender, :step_two, :step_three, :step_four,
                                             :step_five, :step_six, :step_seven, :step_eight, :step_nine, :step_ten,
                                             :camp_id)
  end

  def active?
    redirect_to root_path, alert: 'Application has been submitted. You cannot edit now' if @camp_application.status == 'active'
  end
end
