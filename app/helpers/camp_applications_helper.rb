module CampApplicationsHelper
  def show_confirmation(application, status)
    if application.progress.equal?(100) || (application.progress.equal?(90) && application.step_ten.blank?)
      { 'confirm' => 'You cannot edit application after submission. Are you sure to submit?' }
    end
  end
end
