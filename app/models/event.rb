class Event < ApplicationRecord
  validates :title, :date, presence: true
  mount_uploader :picture, PictureUploader

  belongs_to :user
end
