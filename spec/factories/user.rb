# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    email Faker::Internet.unique.email
    password abcd1234
    password_confirm abcd1234
  end
end
