class Camp < ApplicationRecord
  has_and_belongs_to_many :camp_locations
  has_many :camp_applications, dependent: :destroy
  validate :valid_dates?
  validates :name, :start_date, :end_date, presence: true

  def is_finished?
    Date.today > end_date
  end

  private

  def valid_dates?
    errors.add(:end_date, 'must be greater than start date') if start_date >= end_date
  end

  
end
