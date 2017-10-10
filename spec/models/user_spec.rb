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

    it do
      create(:user)
      should validate_uniqueness_of(:email).case_insensitive
    end

    context "format" do
      describe "valid values" do
        it { should allow_value("abcd@1234.com").for(:email) }
        it { should allow_value("foo@bar.co").for(:email) }
        it { should allow_value("a@b.c").for(:email) }
      end

      describe "invalid values" do
        it { should_not allow_value("@.").for(:email) }
        it { should_not allow_value("$%#^@*@&$.%#").for(:email) }
        it { should_not allow_value("abc@123").for(:email) }
        it { should_not allow_value("foo:bar").for(:email) }
      end
    end
  end

  describe "password" do
    it { should have_secure_password }
    it { should validate_length_of(:password).is_at_least(6).on(:create) }
  end

  describe "before_save" do
    context "ensure email has been converted to downcase" do
      it do
        create(:user, email: "Foo@Bar.com")
        expect(User.last.email).to eq("foo@bar.com")
      end
    end
  end

  describe "chirps" do
    before do
      @user = create(:user)
      3.times { create(:chirp, user: @user) }
    end

    it "properly associates chirps with a user" do
      expect(@user.chirps.count).to eq(3)
    end
  end
end
