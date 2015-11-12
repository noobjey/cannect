class User < ActiveRecord::Base

  def self.find_or_create_from_oauth(auth_data)
    user = find_or_create_by(uid: auth_data.uid) do |new_user|
      new_user.provider = auth_data.provider
      new_user.uid      = auth_data.uid
      new_user.username = auth_data.extra.raw_info.login
      new_user.token    = auth_data.credentials.token
    end

    user
  end

  def profile_picture
    github_service.profile.avatar_url
  end


  private

  def github_service
    @github_service ||= GithubService.new(self)
  end

end
