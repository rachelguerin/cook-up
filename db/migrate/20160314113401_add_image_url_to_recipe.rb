class AddImageUrlToRecipe < ActiveRecord::Migration
  def change
  	add_column :recipes, :image_url, :string
  end
end
