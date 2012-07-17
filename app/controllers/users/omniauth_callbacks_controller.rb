class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def cas
    @user = User.find_for_cas(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "CAS"
      sign_in_and_redirect @user, :event => :authentication
      session[:cas_user] = @user.login
      binding.pry
    else
      session["devise.cas_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end

  end
end
