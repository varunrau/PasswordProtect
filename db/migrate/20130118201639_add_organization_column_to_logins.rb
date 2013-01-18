class AddOrganizationColumnToLogins < ActiveRecord::Migration
  def change
    add_column :logins, :org, :string
  end
end
