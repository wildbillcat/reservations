class Users::RegistrationsController < Devise::RegistrationsController
  skip_filter :app_setup
  skip_filter :first_time_user
  
  def new
    if @app_configs.auth_provider == "CAS"
      redirect_to user_omniauth_authorize_path(:cas)
      return
    end

    super
  end

  def create
    super

    resource.is_admin = 1 if User.first.nil?

    binding.pry
    if resource.save
      session[:user_login] = resource.login
   end
  end
end
