class Like < ApplicationRecord
  belongs_to :user
  belongs_to :chirp
  validates :user_id, presence: true
  validates :chirp_id, presence: true
end
