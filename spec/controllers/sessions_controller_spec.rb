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
      it "sets the user_id session variable to the user's id" do
        post :create, params: { email: @user.email, password: @user.password }
        expect(session[:user_id]).to eq(@user.id)
      end
    end
  end

  describe "DELETE #destroy" do
  end
end
