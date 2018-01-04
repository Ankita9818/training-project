class ChangeCategoryColumnType < ActiveRecord::Migration[5.1]
  def change
    change_column :ingredients, :category, :boolean
  end
end
