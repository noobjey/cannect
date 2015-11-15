class UsersController < ApplicationController

  def follow
    if follow?
      current_user.follow(find_user())
    elsif unfollow?
      current_user.unfollow(find_user())
    end

    redirect_to dashboard_path
  end


  private

  def find_user
    User.find_by(id: params[:id])
  end

  def unfollow?
    http_method == "delete"
  end

  def follow?
    http_method == "put" || http_method == "patch"
  end

  def http_method
    params["_method"]
  end
end
