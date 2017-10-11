# frozen_string_literal: true

FactoryGirl.define do
  factory :user_relationship do
    user          { create(:user) }
    followed_user { create(:user) }
  end
end
