module CampApplicationsHelper
	def show_confirmation(application, status)
		if application.progress.equal?(100) || (application.progress.equal?(90) && application.step_ten.nil?)
			arr = ['confirm', 'You cannot edit application after submission. Are you sure to submit?']
			Hash[*arr.flatten]
		end
	end
end
