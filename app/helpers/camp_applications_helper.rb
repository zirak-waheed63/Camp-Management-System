module CampApplicationsHelper
  def show_confirmation(application, status)
    if application.progress.equal?(CampApplication::TOTAL_PERCENTAGE) || (application.progress.equal?(CampApplication::LAST_STEP_PERCENTAGE) && application.step_ten.blank?)
      { 'confirm' => 'You cannot edit application after submission. Are you sure to submit?' }
    end
  end
end
