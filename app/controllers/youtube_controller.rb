class YoutubeController < ApplicationController

  def create_playlist
    yt = current_user.youtube
    yt.delete_playlists title: 'Top 40'
    playlist = yt.create_playlist title: 'Top 40'
    ids = find_urls
    ids.each { |id| playlist.add_video id }
    flash[:success] = 'Playlist is created'
    redirect_to root_url
  end

  def find_urls
    ids = []
    top_list[0..9].each do |item|
      search_client.search(query: item, max_results: 1) do |v|
        ids << v['id']
      end
    end
    ids
  end

  def search_client
    @search_client ||= Yourub::Client.new
  end
end
