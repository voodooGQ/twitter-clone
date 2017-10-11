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
end
