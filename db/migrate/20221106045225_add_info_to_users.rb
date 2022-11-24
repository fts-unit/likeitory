class AddInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    # migrationファイル名：カラム名、命名失敗のため不一致
    add_column :users, :intro, :string
  end
end
