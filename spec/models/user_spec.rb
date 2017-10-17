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
#  username        :string           not null
#  image_path      :string
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

  describe "instance_methods" do
    before do
      3.times { |i| instance_variable_set("@user_#{i+1}", create(:user)) }
      3.times do |c|
        create(:chirp, user: @user_2)
        create(:chirp, user: @user_3)
      end
      create(:chirp, user: @user_1)
      create(:user_relationship, user: @user_1, followed_user: @user_2)
      create(:user_relationship, user: @user_1, followed_user: @user_3)
      create(:like, user: @user_1, chirp: @user_2.chirps.first)
    end

    describe "chirp_feed" do
      it { expect(@user_1.chirp_feed.count).to eq(7) }
    end

    describe "following?" do
      it { expect(@user_1.following?(@user_2)).to be_truthy }
      it { expect(@user_2.following?(@user_1)).to be_falsey }
    end

    describe "follow!" do
      it do
        expect{ @user_2.follow!(@user_1) }.to change{
          UserRelationship.all.count
        }.by(1)
      end
    end

    describe "unfollow!" do
      it do
        expect{ @user_1.unfollow!(@user_2) }.to change{
          UserRelationship.all.count
        }.by(-1)
      end
    end

    describe "liked?" do
      it { expect(@user_1.liked?(@user_2.chirps.first)).to be_truthy }
      it { expect(@user_1.liked?(@user_3.chirps.last)).to be_falsey }
    end

    describe "like!" do
      it do
        expect{ @user_1.like!(@user_3.chirps.first) }.to change{
          Like.all.count
        }.by(1)
      end
    end

    describe "unlike!" do
      it do
        expect{ @user_1.unlike!(@user_2.chirps.first) }.to change{
          Like.all.count
        }.by(-1)
      end
    end
  end
end
