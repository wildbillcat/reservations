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
    binding.pry

    build_resource
    if User.first.nil?
      resource.is_admin = 1 
      resource.save
      session[:user_login] = resource.login
      sign_in(resource_name, resource)
      redirect_to new_app_configs_path
      return
    end

    resource.login = resource.email

    super

  end
end
