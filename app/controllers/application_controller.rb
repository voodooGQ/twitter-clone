# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id
  end

  helper_method :current_user

  def authorize
    redirect_to login_url, alert: "Not authorized" unless current_user
  end
end
