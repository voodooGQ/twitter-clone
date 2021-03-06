# frozen_string_literal: true

require "rails_helper"

RSpec.describe LikesController, type: :controller do
  let(:subject) { described_class }

  before do
    @user = create(:user)
    session[:user_id] = @user.id
    @user_2 = create(:user)
    @chirp = create(:chirp, user: @user_2 )
    @chirp_2 = create(:chirp, user: @user_2)
    @like = create(:like, chirp: @chirp, user: @user )
  end

  describe "POST #create" do
    before do
      post :create, params: {
        like: {
          chirp_id: @chirp_2.id
        }
      }
    end

    it "properly likes the chirp" do
      expect(@user.liked_chirps.count).to eq(2)
      expect(@chirp_2.likes.count).to eq(1)
    end

    it "redirects the user to the feed_url by default" do
      expect(controller).to redirect_to(feed_url)
    end
  end

  describe "DELETE #destroy" do
    before do
      post :destroy, params: { id: @like.id }
    end

    it "properly removes the like" do
      expect(@user_2.liked_chirps.count).to eq(0)
      expect(@chirp.likes.count).to eq(0)
    end

    it "redirects the user to the feed_url by default" do
      expect(controller).to redirect_to(feed_url)
    end
  end
end
