Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, configatron.auth_providers.twitter.key, configatron.auth_providers.twitter.secret
  provider :facebook, configatron.auth_providers.facebook.key, configatron.auth_providers.facebook.secret, {:provider_ignores_state => true}
end
