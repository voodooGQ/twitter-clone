# frozen_string_literal: true

FactoryGirl.define do
  factory :chirp do
    message Faker::HarryPotter.quote
    user
  end
end
