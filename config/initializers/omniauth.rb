Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.yt_client_id, Rails.application.secrets.yt_client_secret, scope: 'userinfo.profile,youtube'
end
