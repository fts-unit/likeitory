class AddLikerIdToLikestories < ActiveRecord::Migration[5.2]
  def change
    add_column :likestories, :liker_id, :integer
  end
end
