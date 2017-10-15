# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "user#{n}" }
    sequence(:email) {|n| "user#{n}@email.com"}
    image_path { nil }
    password { "abcd1234" }
    password_confirmation { "abcd1234" }
  end
end
