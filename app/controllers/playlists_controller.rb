class PlaylistsController < ApplicationController

  def index
    @top = top_list
    @images = images
  end

  def create_playlist
    service = CreatePlaylist.new(current_user, top_list)
    service.create_in_background
    flash[:success] = 'Playlist will be created'
    redirect_to root_url
  end

end
