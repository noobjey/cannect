class DashboardController < ApplicationController
  before_action :require_user

  def index
    @groups = Group.all
    @owned_groups = Group.where(owner_id: current_user.id)
  end
end
