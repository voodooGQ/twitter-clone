# frozen_string_literal: true

FactoryGirl.define do
  factory :like do
    user { create(:user) }
    chirp { create(:chirp) }
  end
end
