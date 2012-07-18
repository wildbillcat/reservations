class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_filter :app_setup
  skip_filter :first_time_user

  def cas
    @user = User.find_for_cas(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "CAS"
      sign_in_and_redirect @user, :event => :authentication
      session[:user_login] = @user.login
    elsif User.first.nil?
      session[:user_login] = @user.login
      redirect_to new_admin_user_path
      return
    else
      session["devise.cas_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end

  end
end
