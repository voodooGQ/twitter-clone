class FeedController < ApplicationController
  def index
    authorize
    @feed = current_user.chirp_feed
    @chirp  = current_user.chirps.build
  end
end
