class RemoveAutoListFromIngredient < ActiveRecord::Migration
  def change
  	remove_column :ingredients, :auto_list
  end
end
