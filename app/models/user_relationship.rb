class UserRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :followed_user, class_name: "User"
  validates  :user_id, presence: true
  validates  :followed_user_id, presence: true
end
