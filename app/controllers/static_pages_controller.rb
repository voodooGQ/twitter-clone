#  frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @chirps = Chirp.all
  end
end
