class Groups::FollowsController < ApplicationController

  def update
    group_members("follow")

    redirect_to dashboard_path
  end

  def destroy
    group_members("unfollow")

    # what was there
    # find_group().users.each {|member| current_user.unfollow(member)}

    redirect_to dashboard_path
  end

  private

  def find_group
    Group.find_by(id: params[:group_id])
  end

  # Need to ask about this, don't like theres hardcode string dependency on method name
  # Refactoring in ide will not catch this
  def group_members(method)
    find_group().users.each { |member| current_user.send(method.to_sym, member) }
  end
end
