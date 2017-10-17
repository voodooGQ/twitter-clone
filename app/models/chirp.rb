# frozen_string_literal: true
# == Schema Information
#
# Table name: chirps
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class Chirp < ApplicationRecord
  belongs_to :user
  validates :message, presence: true, length: { maximum: 141 }

  default_scope -> { order("created_at DESC") }

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
end
