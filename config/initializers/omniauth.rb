Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret, 
            :scope => 'email,user_birthday,read_stream'
end
