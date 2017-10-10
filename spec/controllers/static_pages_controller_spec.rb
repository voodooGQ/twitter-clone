# frozen_string_literal: true
require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  let(:subject) { described_class }

  describe "GET home" do
    it "responds successfully" do
      get :home
      expect(response.status).to eq(200)
    end

    context "if user is logged in" do
      before do
        @user = create(:user)
        session[:user_id] = @user.id
      end

      it "redirects the user to their feed_page" do
        get :home
        expect(response).to redirect_to(feed_url)
      end
    end
  end
end
