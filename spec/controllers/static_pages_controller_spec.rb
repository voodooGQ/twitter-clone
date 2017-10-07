# frozen_string_literal: true
require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  let(:subject) { described_class }

  describe "GET home" do
    it "responds successfully" do
      get :home
      expect(response.status).to eq(200)
    end
  end
end
