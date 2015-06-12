class CreatePlaylist

  def initialize(user, list)
    @user = user
    @list = list
  end


  def create_in_background
    yt = @user.youtube
    yt.delete_playlists title: 'Kiss_fm_top'
    playlist = yt.create_playlist title: 'Kiss_fm_top'
    ids = find_urls
    ids.each { |id| playlist.add_video id }
  end
  handle_asynchronously :create_in_background

  def success(job)

  end

  private

  def find_urls
    ids = []
    @list.each do |item|
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
