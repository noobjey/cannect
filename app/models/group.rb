class Group < ActiveRecord::Base
  validates :name, uniqueness: true

  has_many :group_users
  has_many :users, through: :group_users

  def owner
    User.find_by(id: self.owner_id)
  end

end
