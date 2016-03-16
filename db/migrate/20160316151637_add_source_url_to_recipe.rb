class AddSourceUrlToRecipe < ActiveRecord::Migration
  def change
  	add_column :recipes, :source_url, :string
  end
end
