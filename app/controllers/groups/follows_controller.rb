class Groups::FollowsController < ApplicationController

  def update
    current_user.follow_users(groups_users)

    redirect_to dashboard_path
  end

  def destroy
    current_user.unfollow_users(groups_users)

    redirect_to dashboard_path
  end


  private

  def groups_users
    Group.find_by(id: params[:group_id]).users
  end
end
