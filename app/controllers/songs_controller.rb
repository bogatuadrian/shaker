class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show

  end

  def new

  end

  def create
    Song.new(params).save
  end
end
