class AddOriginalIdToRecipe < ActiveRecord::Migration
  def change
  	add_column :recipes, :original_id, :integer, index: true
  end
end
