class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :food_type
      t.boolean :auto_list

      t.timestamps null: false
    end
  end
end
