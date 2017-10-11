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

  describe "follows" do
    before do
      @user_1 = create(:user)
      @user_2 = create(:user)

      @relationship = create(
        :user_relationship,
        user: @user_1,
        followed_user: @user_2
      )
    end

    it "returns the proper number of 'followed_users'" do
      expect(@user_1.followed_users.count).to eq(1)
      expect(@user_2.followed_users.count).to eq(0)
    end

    it "returns the proper number of 'followers'" do
      expect(@user_1.followers.count).to eq(0)
      expect(@user_2.followers.count).to eq(1)
    end
  end

  describe "chirp_feed" do
    before do
      3.times do |i|
        instance_variable_set("@user_#{i+1}", create(:user))
      end

      3.times do |c|
        create(:chirp, user: @user_2)
        create(:chirp, user: @user_3)
      end

      create(:chirp, user: @user_1)

      create(:user_relationship, user: @user_1, followed_user: @user_2)
      create(:user_relationship, user: @user_1, followed_user: @user_3)
    end

    it "returns the correct number of chirps" do
      expect(@user_1.chirp_feed.count).to eq(7)
    end
  end
end
