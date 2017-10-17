# == Schema Information
#
# Table name: user_relationships
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  followed_user_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class UserRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :followed_user, class_name: "User"
  validates  :user_id, presence: true
  validates  :followed_user_id, presence: true
end
