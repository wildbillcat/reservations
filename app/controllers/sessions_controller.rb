class SessionsController < ApplicationController

  skip_filter :authorize
  skip_filter :first_time_user
  skip_filter :app_setup

  def create
    binding.pry
    if @app_configs.auth_provider == "CAS"
      session[:user_login] = auth_hash[:uid]
    elsif @app_configs.auth_provider == "Identity"
      session[:user_login] = params[:login]
    end
    redirect_to root_path
  end

  def destroy
    session[:user_login] = nil
    
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
