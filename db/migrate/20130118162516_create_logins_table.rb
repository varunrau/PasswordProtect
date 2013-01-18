class CreateLoginsTable < ActiveRecord::Migration
  def up
    create_table :logins do |t|
      t.string :user_name
      t.string :password

      t.timestamps
    end
  end

  def down
    drop_table :logins
  end
end
