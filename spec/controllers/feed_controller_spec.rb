# frozen_string_literal: true
require "spec_helper"

RSpec.describe FeedController, type: :controller do
  let(:subject) { described_class }

  before do
    @user = create(:user)
    session[:user_id] = @user.id
    @user_chirps = create_list(:chirp, 5, user: @user)

    @user_2 = create(:user)
    @user_2_chirps = create_list(:chirp, 5, user: @user_2)

    @rel = create(:user_relationship, user: @user, followed_user: @user_2)
  end

  describe "GET #index" do
    before { get :index }

    it "returns the correct number of chirps in a feed" do
      expect(controller.instance_variable_get(:@feed).count).to eq(10)
    end
  end
end
