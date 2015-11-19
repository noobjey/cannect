class GroupsController < ApplicationController
  before_action :require_user
  before_action :require_group_owner, only: [:edit, :update, :destroy]

  def new
    @group = Group.new
    @users = User.order(:name)
    @owner_id = current_user.id
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
    @users = User.order(:name)
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

  def require_group_owner
    redirect_to dashboard_path unless current_group.owner_id == current_user.id
  end

end
