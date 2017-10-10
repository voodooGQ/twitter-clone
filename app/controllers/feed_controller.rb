class FeedController < ApplicationController
  def index
    authorize
  end
end
