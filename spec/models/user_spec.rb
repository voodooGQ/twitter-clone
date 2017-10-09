# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require "rails_helper"

RSpec.describe User, type: :model do
  describe "email" do
    it { should validate_presence_of(:email) }
  end

  describe "password" do
    it { should have_secure_password }
    it { should validate_length_of(:password).is_at_least(6).on(:create) }
  end
end
