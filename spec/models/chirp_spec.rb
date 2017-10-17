# frozen_string_literal: true
# == Schema Information
#
# Table name: chirps
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


require "rails_helper"

RSpec.describe Chirp, type: :model do
  describe "before_save" do
    describe "message" do
      context "throws an error if not supplied" do
        it do
          expect { create(:chirp, message: nil) }.to raise_error(
            ActiveRecord::RecordInvalid
          )
        end
      end

      context "throws an error if over 141 characters" do
        it do
          expect { create(:chirp, message: Faker::Lorem.characters(150)) }.to(
            raise_error(ActiveRecord::RecordInvalid)
          )
        end
      end
    end
  end
end
