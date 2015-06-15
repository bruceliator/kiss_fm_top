class PlaylistsController < ApplicationController

  def index
    @top = top_list
    @images = images
  end

  def create_playlist
    AddVideoJob.new.async.perform(current_user, top_list)
    flash[:success] = 'Playlist will be created'
    redirect_to root_url
  end

end
