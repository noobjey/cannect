class GroupsController < ApplicationController
  def new
    @group = Group.new
    @users = User.order(:name)
  end

  def create
    group = Group.new(allowed_params)

    if group.save
      add_users_to(group)
      redirect_to dashboard_path
    end
  end

  def edit
    @group = current_group
    @users = User.order(:username)
  end

  def update
    group = current_group

    if group
      group.update_attributes(allowed_params)
      add_users_to(group)

      redirect_to dashboard_path
    end
  end

  def destroy
    group = current_group

    if group
      group.delete
      redirect_to dashboard_path
    end
  end


  private

  def current_group
    Group.find_by(id: params[:id])
  end

  def allowed_params
    params.require(:group).permit(:name, :description, :owner_id, user_ids: [])
  end

  def user_ids_to_add
    allowed_params[:user_ids].reject(&:empty?)
  end

  def add_users_to(group)
    group.user_ids = user_ids_to_add
  end

end
