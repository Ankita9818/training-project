class CreateInventory < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories do |t|
      t.references :branch, index: true
      t.references :ingredient, index: true
      t.integer :quantity, default: 0
      t.timestamps
    end
  end
end
