class UserRelationshipsController < ApplicationController
  before_action :authorize

  def create
    @user = User.find(params[:user_relationship][:followed_user_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to current_page_url }
      format.js
    end
  end

  def destroy
    @user = UserRelationship.find(params[:id]).followed_user
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to current_page_url }
      format.js
    end
  end
end
