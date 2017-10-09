# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:subject) { described_class }
  describe "GET #new" do
    before { get :new }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "assigns a new user object to the @user instance variable" do
      expect(assigns(:user)).to be_an(User)
    end
  end
end
