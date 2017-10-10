class CreateChirps < ActiveRecord::Migration[5.0]
  def change
    create_table :chirps do |t|
      t.integer :user_id
      t.text :message

      t.timestamps
    end
  end
end
