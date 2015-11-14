class DashboardController < ApplicationController

  def index
    @group = Group.first
  end
end
