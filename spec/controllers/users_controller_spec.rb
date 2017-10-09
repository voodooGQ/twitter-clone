# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:subject) { described_class }

  describe "GET #new" do
    before { get :new }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
        context "when invalid parameters are passed" do
      context "when the user parameter is empty" do
        it do
          expect{post :create, params: { user: {} }}.to raise_error(
            ActionController::ParameterMissing
          )
        end
      end

      context "when the parameter is invalid" do
        it do
          post :create, params: { user: {email: "@@@"} }
          expect(controller).to render_template(:new)
        end
      end
    end

    context "when valid parameters are passed" do
      let(:valid_user_params) do
        {
          email: "test@test.com",
          password: "123456",
          password_confirmation: "123456"
        }
      end
      before { post :create, params: { user: valid_user_params } }

      it "sets the used_id session variable to the new user's id" do
        expect(session[:user_id]).to eq(User.last.id)
      end

      it "redirects the user to the root_url" do
        expect(response).to redirect_to(root_url)
      end

      it "sends a 'Thank you for signing up!' flash notice" do
        expect(controller).to set_flash[:notice].to(
          "Thank you for signing up!"
        )
      end
    end
  end
end
