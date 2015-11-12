class Group < ActiveRecord::Base
  validates :name, uniqueness: true

  has_many :group_users
  has_many :users, through: :group_users
end
