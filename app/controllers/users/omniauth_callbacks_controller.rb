class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_filter :app_setup

  def cas
    @user = User.find_for_cas(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "CAS"
      sign_in @user#, :event => :authentication
      session[:user_login] = @user.login
      redirect_to root_path
    elsif User.first.nil?
      session[:user_login] = @user.login
      redirect_to new_admin_user_path
      return
    else
      session["devise.cas_data"] = request.env["omniauth.auth"]
      session[:user_login] = @user.login
      redirect_to new_user_path
    end

  end
end
