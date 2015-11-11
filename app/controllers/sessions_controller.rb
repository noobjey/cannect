class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.find_or_create_from_oauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_to dashboard_path
    end
  end

end
