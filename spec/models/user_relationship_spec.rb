# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserRelationship, type: :model do
  it "raises an error if the user is not supplied" do
    expect { create(:user_relationship, user: nil) }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end

  it "raises an error if the followed_user is not supplied" do
    expect { create(:user_relationship, followed_user: nil) }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end
end
