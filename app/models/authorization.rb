class Authorization < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  def self.find_from_oauth(auth_data)
    find_by_provider_and_uid(auth_data[:uid], auth_data[:provider])
  end

  def self.create_from_user_and_oauth(user, auth_data)
    Authorization.create(
      user_id: user.id,
      provider: auth_data[:provider],
      uid: auth_data[:uid],
      token: auth_data[:credentials][:token],
      secret: auth_data[:credentials][:secret]
    )
  end
end
