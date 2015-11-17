class SessionsController < ApplicationController

  def new
  end

  def create
    auth_data = request.env['omniauth.auth']
    auth      = Authorization.find_from_oauth(auth_data)

    if provider_already_authorized?(auth)
      login_user_with_id(auth.user_id)
    elsif user_already_logged_in?
      add_new_authorization_for(current_user, auth_data)
      add_new_service_for(current_user, auth_data)
    else
      user = create_new_user(auth_data)
      add_new_authorization_for(user, auth_data)
      login_user_with_id(user.id)
    end

    redirect_to dashboard_path
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private

  def login_user_with_id(id)
    session[:user_id] = id
  end

  def provider_already_authorized?(auth)
    !!auth
  end

  def user_already_logged_in?
    !!current_user
  end

  def add_new_authorization_for(user, auth_data)
    Authorization.create_from_user_and_oauth(user, auth_data)
  end

  def add_new_service_for(user, auth_data)
    user.add_service_oauth(auth_data)
  end

  def create_new_user(auth_data)
    User.create_from_oauth(auth_data)
  end
end
