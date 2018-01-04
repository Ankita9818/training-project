class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.float :price
      t.integer :category
      t.boolean :extra_allowed, default: false
      t.timestamps
    end
  end
end
