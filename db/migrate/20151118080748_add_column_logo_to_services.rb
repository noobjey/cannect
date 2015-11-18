class AddColumnLogoToServices < ActiveRecord::Migration
  def change
    add_column :services, :logo, :string
  end
end
