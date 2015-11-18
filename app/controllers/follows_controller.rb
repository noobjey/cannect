class FollowsController < ApplicationController
  def create
    # byebug
    puts params
    redirect_to dashboard_path
  end

  def delete
    puts params
    redirect_to dashboard_path
  end

  def twitter_service
    @twitter_service ||= TwitterService.new(self.ser)
  end

  def github_service
    @github_service ||= GithubService.new(self)
  end
end
