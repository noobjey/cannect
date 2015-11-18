class User < ActiveRecord::Base
  has_many :authorizations
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :service_users
  has_many :services, through: :service_users

  def self.create_from_oauth(auth_data)
    user = User.create(name: auth_data[:info][:name], image_url: auth_data[:info][:image])
    user.add_new_service(auth_data)

    user
  end

  def inactive_services()
    Service.all - self.services
  end

  def username_for_service(service)
    self.authorizations.find_by(provider: service.provider).username
  end

  def add_new_service(auth_data)
    self.services << Service.find_by(provider: auth_data[:provider])
  end

end
