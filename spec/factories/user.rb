# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user_#{n}@email.com"}
    password "abcd1234"
    password_confirmation "abcd1234"
  end
end
