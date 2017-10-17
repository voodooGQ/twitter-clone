# frozen_string_literal: true
# == Schema Information
#
# Table name: user_relationships
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  followed_user_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#


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
