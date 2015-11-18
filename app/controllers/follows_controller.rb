class FollowsController < ApplicationController
  def create
    allowed_params.each do |service, data|
      ServiceFactory.create_service(current_user, service).follow(user_to_follow(data, service))
    end
    redirect_to dashboard_path
  end


  def destroy
    allowed_params.each do |service, data|
      ServiceFactory.create_service(current_user, service).unfollow(user_to_follow(data, service))
    end
    redirect_to dashboard_path
  end


  private

  def user_to_follow(data, service)
    Authorization.find_by_provider_and_uid(service, data[:user_to_follow_uid]).username
  end

  def allowed_params
    params.require(:follows).permit(github: :user_to_follow_uid, twitter: :user_to_follow_uid )
  end
end
