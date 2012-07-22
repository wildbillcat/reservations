class Users::RegistrationsController < Devise::RegistrationsController
  skip_filter :app_setup
  skip_filter :first_time_user

  def new
    if @app_configs.auth_provider == "CAS"
      redirect_to user_omniauth_authorize_path(:cas)
      return
    end

    super
  end

  def create

    build_resource


    resource.login = resource.email

    if User.first.nil?
      resource.is_admin = 1 
      resource.skip_confirmation!
      resource.save
      session[:user_login] = resource.login
      sign_in(resource_name, resource)
      redirect_to new_app_configs_path
      return
    end

    # The code below is content of Devise Registrations#create method except for build_resource because then
    # it rebuilds it and forgets about setting the login to be e-mail so the validation fails 

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    binding.pry
    resource.login = params[:user][:email]
    binding.pry

    if resource.update_with_password(resource_params)
      if is_navigational_format?
        if resource.respond_to?(:pending_reconfirmation?) && resource.pending_reconfirmation?
          flash_key = :update_needs_confirmation
        end
        set_flash_message :notice, flash_key || :updated
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

end
