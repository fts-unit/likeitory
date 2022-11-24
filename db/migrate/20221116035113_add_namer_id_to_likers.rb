class AddNamerIdToLikers < ActiveRecord::Migration[5.2]
  def change
    add_column :likers, :namer_id, :integer
  end
end
