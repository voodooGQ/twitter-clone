class FeedController < ApplicationController
  def index
    redirect_to login_url unless current_user
  end
end
