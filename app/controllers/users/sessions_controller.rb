class Users::SessionsController < Devise::SessionsController
  skip_filter :app_setup

  def new
    if @app_configs.auth_provider == "CAS"
      redirect_to user_omniauth_authorize_path(:cas)
      return
    end
    super
  end

  def destroy
    super
    cas_logout = "<a href=\"https://#{CAS_HOST}/logout\">here</a>"
    if @app_configs.auth_provider == "CAS"
      flash[:notice] = "You have successfully signed out of #{@app_configs.site_title}.
      If you would like to sign out of CAS as well please click #{cas_logout}.".html_safe
    end
  end
end
