class RenameColumnUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :resent_sent_at, :reset_password_sent_at
  end
end
