class ChirpsController < ApplicationController
  before_action :correct_user, only: :destroy
  before_action :authorize, only: [:create, :destroy]

  def create
    @chirp = current_user.chirps.build(chirp_params)
    if @chirp.save
      flash[:success] = "Chirp created!"
    else
      flash[:error] = "Uh oh, something went wrong, try again!"
    end

    redirect_to feed_url
  end

  private

  def chirp_params
    params.require(:chirp).permit(:message)
  end

  def correct_user
    @chirp = current_user.chirps.find_by(id: params[:id])
    redirect_to root_url if @chirp.nil?
  end
end
