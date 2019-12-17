class Artifact < ApplicationRecord
  validates :comment, :video, presence: true
  belongs_to :event
  belongs_to :user
  mount_uploader :video, VideoUploader
end
