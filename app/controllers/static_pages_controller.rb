#  frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    # Automatically redirect to a users feed page if they're logged in.
    redirect_to feed_url if current_user
  end
end
