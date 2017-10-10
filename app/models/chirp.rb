# frozen_string_literal: true

class Chirp < ApplicationRecord
  belongs_to :user
  validates :message, presence: true, length: { maximum: 141 }

  # Let's just hack it down to 141 if it gets saved larger than that
  before_save { self.message = "#{self.message[0..138]}..." }
end
