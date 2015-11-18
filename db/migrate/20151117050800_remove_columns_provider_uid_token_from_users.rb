class RemoveColumnsProviderUidTokenFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :provider
      t.remove :uid
      t.remove :token
      t.rename :username, :name
    end
  end
end
