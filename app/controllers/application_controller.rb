class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  URL = 'http://www.kissfm.ua/kissparad/top40'

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def top_list
    doc = Nokogiri::HTML(open(URL))
    singers = doc.css('.block-parad-track-info-name-singer')
    songs = doc.css('.block-parad-track-info-name-song')
    singers.each_with_index.inject([]) do |res, (elm, i)|
      res << elm.content.strip + ' - ' + songs[i].content.strip
    end
  end

  def images
    doc = Nokogiri::HTML(open(URL))
    images = doc.css('.block-parad-track-image img')
    images.each_with_object([]) { |img, arr| arr << img.attr('data-echo') }
  end

  helper_method :current_user, :top_list
end
