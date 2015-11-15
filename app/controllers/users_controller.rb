class UsersController < ApplicationController

  def update
    user_to_follow = User.find_by(id: params[:id])
    current_user.follow(user_to_follow)

    redirect_to dashboard_path
  end
end
