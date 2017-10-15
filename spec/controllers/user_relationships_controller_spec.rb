# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserRelationshipsController, type: :controller do
  let(:subject) { described_class }

  before do
    @user = create(:user)
    session[:user_id] = @user.id

    @user_2 = create(:user)
    @user_3 = create(:user)
    @rel = create(:user_relationship, user: @user, followed_user: @user_2)
  end

  describe "POST #create" do
    before do
      post :create, params: {
        user_relationship: {
          followed_user_id: @user_3.id
        }
      }
    end

    it "properly follows the user" do
      expect(@user.followed_users.count).to eq(2)
      expect(@user_3.followers.count).to eq(1)
    end

    it "redirects the user to the feed_url by default" do
      expect(controller).to redirect_to(feed_url)
    end
  end

  describe "DELETE #destroy" do
    before do
      post :destroy, params: { id: @rel.id }
    end

    it "properly removes the relationship" do
      expect(@user.followed_users.count).to eq(0)
      expect(@user_2.followers.count).to eq(0)
    end

    it "redirects the user to the feed_url by default" do
      expect(controller).to redirect_to(feed_url)
    end
  end
end
