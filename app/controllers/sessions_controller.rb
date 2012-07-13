class SessionsController < ApplicationController

  skip_filter :authorize
  skip_filter :first_time_user

  def create
    session[:cas_user] = auth_hash[:uid]
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
