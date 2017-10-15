class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :chirp_id

      t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, :chirp_id
    add_index :likes, [:user_id, :chirp_id], unique: true
  end
end
