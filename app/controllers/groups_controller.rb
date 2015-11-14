class GroupsController < ApplicationController
  def new
    @group = Group.new
    @users = User.order(:username)
  end

  def create
    group = Group.new(allowed_params)

    if group.save
      add_users_to(group)
      redirect_to dashboard_path
    end
  end


  private

  def allowed_params
    params.require(:group).permit(:name, :description, :owner_id)
  end

  def user_ids_to_add
    params[:group][:user_ids].reject(&:empty?)
  end

  def users_to_add
    user_ids_to_add.map do |id|
      User.find_by(id: id.to_i)
    end
  end

  def add_users_to(group)
    users_to_add.each do |user|
      group.users << user
    end
  end

end
