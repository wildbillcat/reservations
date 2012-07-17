class SessionsController < ApplicationController

  skip_filter :authorize
  skip_filter :first_time_user
  skip_filter :app_setup

  def create
    if @app_configs.auth_provider == "CAS"
      session[:user_login] = auth_hash[:uid]
    elsif @app_configs.auth_provider == "Identity"
      session[:user_login] = params[:auth_key]
    end
    redirect_to root_path
  end

  def destroy
    session[:user_login] = nil
    
  end

  def failure
    redirect_to new_session_path, alert: "Authentication failed, please try again."
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
