class RemovePrepTimeFromRecipe < ActiveRecord::Migration
  def change
  	remove_column :recipes, :prep_time
  end
end
