class User < ActiveRecord::Base
  has_many :authorizations
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :service_users
  has_many :services, through: :service_users

  def self.create_from_oauth(auth_data)
    user = User.create(name: auth_data[:info][:name])
    user.add_new_service(auth_data)

    user
  end

  def add_new_service(auth_data)
    self.services << Service.find_by(provider: auth_data[:provider])
  end

  def profile_picture
    github_service.profile.avatar_url
  end

  def following
    github_service.profile.following
  end

  def follow(user)
    github_service.follow(user)
  end

  def unfollow(user)
    github_service.unfollow(user)
  end

  def follow_users(users)
    users.each { |user| self.follow(user) }
  end

  def unfollow_users(users)
    users.each { |user| self.unfollow(user) }
  end


  private

  def github_service
    @github_service ||= GithubService.new(self)
  end

end
