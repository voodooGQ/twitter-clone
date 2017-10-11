class FeedController < ApplicationController
  def index
    authorize
    @feed = current_user.chirp_feed
  end
end
