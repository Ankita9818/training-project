class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.string :name
      t.time :opening_time
      t.time :closing_time
      t.boolean :default_res
      t.timestamps
    end
  end
end
