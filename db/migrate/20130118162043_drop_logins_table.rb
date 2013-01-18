class DropLoginsTable < ActiveRecord::Migration
  def up
    drop_table :logins
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
