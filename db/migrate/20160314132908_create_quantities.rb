class CreateQuantities < ActiveRecord::Migration
  def change
    create_table :quantities do |t|
      t.integer :quantity
      t.string :unit
      t.references :ingredient, index: true
      t.references :recipe, index: true
      t.timestamps null: false
    end
  end
end
