class AddUsernameToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :username, :string
    change_column_null :users, :username, false
  end

  def down
    remove_column :users, :username, :string
  end
end
