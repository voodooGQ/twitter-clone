# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChirpsController, type: :controller do
  let(:subject) { described_class }

  before do
    @user = create(:user)
    session[:user_id] = @user.id
  end

  describe "POST #create" do
    context "when invalid parameters are passed" do
      before do
        post :create, params: {
          chirp: { message: Faker::Lorem.characters(142)}
        }
      end

      it "sends a danger flash notice" do
        expect(controller).to set_flash[:danger].to(
          "Uh oh, something went wrong, try again!"
        )
      end

      it "does not create a new chirp" do
        expect(Chirp.all.count).to eq(0)
      end
    end

    context "when valid parameter are passed" do
      before do
        post :create, params: {
          chirp: { message: Faker::Lorem.characters(141)}
        }
      end

      it "sends a success flash notice" do
        expect(controller).to set_flash[:success].to(
          "Chirp created!"
        )
      end

      it "creates a new chirp" do
        expect(Chirp.all.count).to eq(1)
      end
    end
  end

  describe "DELETE #destroy" do
  end
end
