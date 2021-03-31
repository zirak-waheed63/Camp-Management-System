class CampApplication < ApplicationRecord
  belongs_to :camp
  belongs_to :user
  has_one_attached :image
  after_initialize :initialize_steps_hash
  validates :name, length: { minimum: 5 }, on: :update, allow_nil: true
  
  STEPS = %w[personal_information step_two step_three step_four step_five step_six step_seven step_eight step_nine step_ten]
  TOTAL_PERCENTAGE = 100.freeze
  LAST_STEP_PERCENTAGE = 90.freeze

  def initialize_steps_hash
    self.steps = STEPS.map { |key| { key => false } }.reduce(&:merge) if self.new_record?
  end

  def complete_step(name)
    current_steps = steps
    current_steps[name] = true
    update(steps: current_steps)
  end

  def status
    status = steps.select { |k, v| !v }.keys.first
    status = 'active' if status.blank?
    status
  end

  def progress
    completed = steps.select { |k, v| v }.keys.size
    total = steps.keys.size
    completed*100/total
  end

  def initialize_from_user(user)
    if steps['personal_information'].blank?
      self.name = user.full_name
      self.email = user.email
      if user.avatar.attached?
        image.attach(user.avatar.blob)
      end
    end
  end

  def active?
    status == 'active'
  end
end
