class FollowsController < ApplicationController
  before_action :require_user

  def create
    allowed_params.each do |user_id, data|
      data.each do |service, data|
        ServiceFactory.create_service(current_user, service).follow(user_to_follow(data, service)) unless following_yourself?(user_id)
      end
    end


    redirect_to dashboard_path
  end

  def destroy
    allowed_params.each do |user_id, data|
      data.each do |service, data|
        ServiceFactory.create_service(current_user, service).unfollow(user_to_follow(data, service)) unless following_yourself?(user_id)
      end
    end

    redirect_to dashboard_path
  end


  private

  def following_yourself?(id)
    current_user == User.find_by(id: id)
  end

  def user_to_follow(data, service)
    Authorization.find_by_provider_and_uid(service, data[:user_to_follow_uid]).username
  end

  # https://github.com/rails/rails/issues/9454
  def allowed_params
    params.require(:follows).permit!
  end

end
