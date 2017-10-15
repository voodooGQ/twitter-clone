class FeedController < ApplicationController
  before_action :authorize

  def index
    @feed = current_user.chirp_feed
    @chirp  = current_user.chirps.build
  end
end
