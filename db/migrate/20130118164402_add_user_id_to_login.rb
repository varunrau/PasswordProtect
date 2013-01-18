class AddUserIdToLogin < ActiveRecord::Migration
  def change
    add_column :logins, :user_id, :integer
  end
end
