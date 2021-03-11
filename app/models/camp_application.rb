class CampApplication < ApplicationRecord
  belongs_to :camp
  belongs_to :user
  has_one_attached :image

  def update_progress
  	progress = 0
  	if name.present?
  		progress +=10
  	end
  	if step_two.present?
  		progress += 10
  	end
  	if step_three.present?
  		progress += 10
  	end
  	if step_four.present?
  		progress += 10
  	end
  	if step_five.present?
  		progress += 10
  	end
  	if step_six.present?
  		progress += 10
  	end
  	if step_seven.present?
  		progress += 10
  	end
  	if step_eight.present?
  		progress += 10
  	end
  	if step_nine.present?
  		progress += 10
  	end
  	if step_ten.present?
  		progress += 10
  	end	
  	self.update(progress: progress)	
  end

  def update_status
  	if name.nil?
  		status = 'personal_information'
  	elsif step_two.nil?
  		status = 'step_two'
  	elsif step_three.nil?
  		status = 'step_three'
  	elsif step_four.nil?
  		status = 'step_four'
  	elsif step_five.nil?
  		status = 'step_five'
  	elsif step_six.nil?
  		status = 'step_six'
  	elsif step_seven.nil?
  		status = 'step_seven'
  	elsif step_eight.nil?
  		status = 'step_eight'
  	elsif step_nine.nil?
  		status = 'step_nine'
  	elsif step_ten.nil?
  		status = 'step_ten'
  	elsif progress = 100
  		status = 'active'
  	else
  		status = 'personal_information'
  	end	
  		self.update(status: status)
  end
end