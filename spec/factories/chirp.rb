# frozen_string_literal: true

FactoryGirl.define do
  factory :chirp do
    message { Faker::HarryPotter.quote[0..140] }
    user
  end
end
