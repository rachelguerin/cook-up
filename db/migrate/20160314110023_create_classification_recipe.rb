class CreateClassificationRecipe < ActiveRecord::Migration
  def change
    create_table :classifications_recipes do |t|
    	t.references :classification, index: true
    	t.references :recipe, index: true
    end
  end
end
