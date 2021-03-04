class Camp < ApplicationRecord
  has_and_belongs_to_many :camp_locations
  validate :valid_dates?
  validates :name, :start_date, :end_date, :status, presence: true

  private

  def valid_dates?
    errors.add(:end_date, 'must be greater than start date') if start_date >= end_date
  end
end
