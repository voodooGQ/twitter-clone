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

      it "redirects the user to the feed_url" do
        expect(response).to redirect_to(feed_url)
      end

      it "sends a 'Logged in!' flash notice" do
        expect(controller).to set_flash[:notice].to("Logged in!")
      end
    end

    context "when not properly authenticated" do
      before { post :create, params: { email: @user.email, password: "foo" } }

      it "renders the :new template" do
        expect(controller).to render_template(:new)
      end

      it "sends a flash alert notifying of an invalid email or password" do
        expect(controller).to set_flash.now[:alert].to(
          "Email or password is invalid"
        )
      end
    end
  end

  describe "DELETE #destroy" do
    before { delete :destroy }

    it "sets the session[:user_id] to nil" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects the user to the root_url" do
      expect(response).to redirect_to(root_url)
    end

    it "sends a 'Logged out!' flash notice" do
      expect(controller).to set_flash[:notice].to("Logged out!")
    end
  end
end
