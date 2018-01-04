class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :body
      t.references :user, index: true
      t.references :inventory, index: true
      t.timestamps
    end
  end
end
