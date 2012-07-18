class Users::SessionsController < Devise::SessionsController
  skip_filter :app_setup
  skip_filter :first_time_user

  def new
    if @app_configs.auth_provider == "CAS"
      redirect_to user_omniauth_authorize_path(:cas)
      return
    end
    super
  end

end
