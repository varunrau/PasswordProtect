class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.string :user_name
      t.string :password

      t.timestamps
    end
  end
end
