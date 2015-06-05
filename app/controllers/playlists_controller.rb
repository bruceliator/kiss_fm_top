class PlaylistsController < ApplicationController

  def index
    @top = top_list
    @images = images
  end

end
