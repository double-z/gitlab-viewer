class RemoveOldTables < ActiveRecord::Migration
  def up
    drop_table :users
    drop_table :users_projects
    drop_table :issues
    drop_table :keys
  end

  def down
  end
end
