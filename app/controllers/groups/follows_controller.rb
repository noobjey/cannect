class Groups::FollowsController < ApplicationController

  def update
    find_group().users.each do |user|
      current_user.follow(user)
    end

    redirect_to dashboard_path
  end


  private

  def find_group
    Group.find_by(id: params[:group_id])
  end
end
