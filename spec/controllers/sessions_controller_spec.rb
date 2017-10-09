# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  before do
    @user = create(:user)
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "when properly authenticated" do
      before do
        post :create, params: { email: @user.email, password: @user.password }
      end

      it "sets the user_id session variable to the user's id" do
        expect(session[:user_id]).to eq(@user.id)
      end

      it "redirects the user to the root_url" do
        expect(response).to redirect_to(root_url)
      end

      it "sends a 'Logged in!' flash notice" do
        expect(controller).to set_flash[:notice].to(/Logged in!/)
      end
    end
  end

  describe "DELETE #destroy" do
  end
end
