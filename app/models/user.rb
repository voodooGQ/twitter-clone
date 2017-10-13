# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :username, presence: true, format: { with: /\A[a-zA-Z0-9]+\Z/ }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  has_many :chirps

  has_many(
    :followed_relationships,
    foreign_key: "user_id",
    class_name: "UserRelationship",
    dependent: :destroy
  )

  has_many(
    :followed_users,
    through: :followed_relationships,
    source: :followed_user
  )

  has_many(
    :follower_relationships,
    foreign_key: "followed_user_id",
    class_name: "UserRelationship",
    dependent: :destroy
  )

  has_many(
    :followers,
    through: :follower_relationships,
    source: :user
  )

  before_save { self.email = email.downcase }

  def chirp_feed
    followed_ids = "SELECT followed_user_id FROM user_relationships WHERE " \
                   "user_id = :user_id"
    Chirp.where(
      "user_id IN (#{followed_ids}) OR user_id = :user_id", user_id: id
    )
  end

  def following?(other_user)
    followed_relationships.find_by(followed_user_id: other_user.id)
  end

  def follow!(other_user)
    followed_relationships.create!(followed_user_id: other_user.id)
  end

  def unfollow!(other_user)
    followed_relationships.find_by(followed_user_id: other_user.id).destroy
  end
end
