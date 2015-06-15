class AddVideoJob
  include SuckerPunch::Job

  def perform(user, list)
    service = CreatePlaylist.new(user, list)
    service.create_in_background
  end
end
