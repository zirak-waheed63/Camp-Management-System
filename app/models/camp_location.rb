class CampLocation < ApplicationRecord
  has_and_belongs_to_many :camps
  validates :name, presence: true, uniqueness: true
end
