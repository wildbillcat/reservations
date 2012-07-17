class Identity < OmniAuth::Identity::Models::ActiveRecord
  validates_uniqueness_of :login

  auth_key("login")

end
