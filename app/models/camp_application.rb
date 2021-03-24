class CampApplication < ApplicationRecord
  belongs_to :camp
  belongs_to :user
  has_one_attached :image
  after_initialize :initialize_steps_hash
  validates :name, length: {minimum: 5}, on: :update, allow_nil: true
  
  STEPS = %w[personal_information step_two step_three step_four step_five step_six step_seven step_eight step_nine step_ten]
  def initialize_steps_hash
    self.steps = STEPS.map { |key| { key => false } }.reduce(&:merge) if steps.blank?
  end

  def complete_step(name)
    current_steps = steps
    current_steps[name] = true
    update(steps: current_steps)
  end

  def status
    status = steps.select { |k, v| !v}.keys.first
    status = 'active' if status.blank?
    return status
  end

  def progress
    completed = steps.select { |k, v| v }.keys.size
    total = steps.keys.size
    return completed*100/total
  end

  def initialize_from_user(user)
    self.name = "#{user.first_name} #{user.middle_name} #{user.last_name}" if name.blank?
    self.email = user.email if email.blank?
    if image.attached?.blank? && user.avatar.attached?
      image.attach(user.avatar.blob)
    end
  end

end
