class Groups::FollowsController < ApplicationController

  def update
    members.each { |member| current_user.follow(member) }

    redirect_to dashboard_path
  end

  def destroy
    members.each { |member| current_user.unfollow(member) }

    redirect_to dashboard_path
  end

  private

  def find_group
    Group.find_by(id: params[:group_id])
  end

  def members
    find_group().users
  end
end
