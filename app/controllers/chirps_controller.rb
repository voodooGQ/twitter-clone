class ChirpsController < ApplicationController
  def index
    @chirps = Chirp.all
  end

  def new
    @chirp = Chirp.new
  end

  def create
    redirect_to root_url, notice: "You must be logged in." unless current_user
    @chirp = Chirp.new(chirp_params[:chirp].merge(user: current_user))
    render @chirp.save ? :index : :new
  end

  private

  def chirp_params
    params.require(:chirp).permit(:message)
  end
end
