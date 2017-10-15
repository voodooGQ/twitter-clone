class AddImagePathToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image_path, :string
  end
end
