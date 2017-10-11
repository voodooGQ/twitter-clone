# frozen_string_literal: true

class Chirp < ApplicationRecord
  belongs_to :user
  validates :message, presence: true, length: { maximum: 141 }

  default_scope -> { order("created_at DESC") }
end
