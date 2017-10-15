class LikesController < ApplicationController
  before_action :authorize

  def create
    @chirp = Chirp.find(params[:like][:chirp_id])
    current_user.like!(@chirp)
    respond_to do |format|
      format.html { redirect_back(fallback_location: feed_url) }
      format.js
    end
  end

  def destroy
    @chirp = Like.find(params[:id]).chirp
    current_user.unlike!(@chirp)
    respond_to do |format|
      format.html { redirect_back(fallback_location: feed_url) }
      format.js
    end
  end
end
