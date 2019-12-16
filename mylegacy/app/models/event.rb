class Event < ApplicationRecord
  validates :title, :date, :picture, presence: true
  has_many :artifacts
  
  mount_uploader :picture, PictureUploader

  belongs_to :user
end
