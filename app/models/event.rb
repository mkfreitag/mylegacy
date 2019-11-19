class Event < ApplicationRecord
  validates :title, :date, :picture, presence: true
  
  mount_uploader :picture, PictureUploader

  belongs_to :user
end
