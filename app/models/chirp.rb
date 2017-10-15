# frozen_string_literal: true

class Chirp < ApplicationRecord
  belongs_to :user
  validates :message, presence: true, length: { maximum: 141 }

  default_scope -> { order("created_at DESC") }

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
end
