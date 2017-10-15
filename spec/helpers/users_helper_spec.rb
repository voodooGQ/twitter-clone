# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersHelper, type: :helper do
  let(:subject) { described_class }

  describe "profile_image_for" do
    context "when the user has an image_path attribute" do
      before { @user = create(:user, image_path: 'foo/bar.jpg') }
      it do
        expect(profile_image_for(@user)).to eq(
          "<img alt=\"#{@user.username}\" class=\"profile_image rounded\" " \
          "src=\"/foo/bar.jpg\" />"
        )
      end
    end

    context "when the user does not have an image_path attribute" do
      before { @user = create(:user) }
      it "returns the proper gravatar url"do
        id = Digest::MD5::hexdigest(@user.email.downcase)
        expect(profile_image_for(@user)).to eq(
          "<img alt=\"#{@user.username}\" class=\"profile_image rounded\" " \
          "src=\"https://secure.gravatar.com/avatar/#{id}?s=50\" />"
        )
      end

      it "returns the proper gravatar url with the requested size" do
        id = Digest::MD5::hexdigest(@user.email.downcase)
        expect(profile_image_for(@user, size: 150)).to eq(
          "<img alt=\"#{@user.username}\" class=\"profile_image rounded\" " \
          "src=\"https://secure.gravatar.com/avatar/#{id}?s=150\" />"
        )
      end
    end
  end
end
