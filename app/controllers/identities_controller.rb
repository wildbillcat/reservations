class IdentitiesController < ApplicationController
  skip_filter :app_setup
  skip_filter :authorize
  skip_filter :first_time_user

  def new
    @identity = env['omniauth.identity']
  end
end
