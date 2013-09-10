class SessionsController < ApplicationController
  skip_before_filter :deny_banned_users

  def destroy
    @current_user = nil
    RubyCAS::Filter.logout(self)
  end
end
