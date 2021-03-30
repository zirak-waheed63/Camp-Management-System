class Camp < ApplicationRecord
  has_and_belongs_to_many :camp_locations
  has_many :camp_applications, dependent: :destroy
  validates :name, :start_date, :end_date, presence: true
  validate :valid_dates?

  def is_finished?
    Date.today > end_date
  end

  private

  def valid_dates?
    if start_date.present? && end_date.present? && start_date >= end_date
      errors.add(:end_date, 'must be greater than start date')
    end
  end
end
