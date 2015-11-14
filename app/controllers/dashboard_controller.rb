class DashboardController < ApplicationController

  def index
    @groups = Group.all
  end
end
