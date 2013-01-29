class AddKeyColumnToLogins < ActiveRecord::Migration
  def change
    add_column :logins, :key, :string
  end
end
