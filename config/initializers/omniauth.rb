Rails.application.config.middleware.use OmniAuth::Builder do
  provider :cas, :host => 'secure.its.yale.edu/cas'
  provider :identity, :fields => [:login]
end
