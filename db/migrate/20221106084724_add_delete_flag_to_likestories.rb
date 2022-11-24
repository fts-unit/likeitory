class AddDeleteFlagToLikestories < ActiveRecord::Migration[5.2]
  def change
    add_column :likestories, :f_del, :boolean, null: false, default: false
  end
end
