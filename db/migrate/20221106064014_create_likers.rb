class CreateLikers < ActiveRecord::Migration[5.2]
  def change
    create_table :likers do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
