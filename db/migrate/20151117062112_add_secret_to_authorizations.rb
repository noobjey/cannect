class AddSecretToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :secret, :string
  end
end
