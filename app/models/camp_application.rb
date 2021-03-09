class CampApplication < ApplicationRecord
  belongs_to :camp
  belongs_to :user
  has_one_attached :image
end