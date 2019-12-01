class Artifact < ApplicationRecord
  validates :comment, presence: true
  belongs_to :event
  belongs_to :user
end
