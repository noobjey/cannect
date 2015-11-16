class Users::FollowsController < ApplicationController
  def update
    current_user.follow(user_to_follow)
    redirect_to dashboard_path
  end

  def destroy
    current_user.unfollow(user_to_follow)
    redirect_to dashboard_path
  end


  private

  def user_to_follow
    User.find_by(id: params[:user_id])
  end

end
