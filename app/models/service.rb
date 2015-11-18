class Service < ActiveRecord::Base
  validates :provider, uniqueness: true

  has_many :service_users
  has_many :users, through: :service_users

end
