require 'rails_helper'

RSpec.describe Quantity do
	describe "check fields" do 
		let(:recipe) {Recipe.new({title: "Recipe title", 
						cook_time: 45, 
						servings: 4, 
						method: "cook it and eat it", 
						image_url:"https://spoonacular.com/recipeImages/Cheesy-Grits-Casserole-637663.jpg", 
						original_id: 123456,
						source_url: "https://thisisthesourceurl"
						})}

		let(:ingredient) {Ingredient.new({name: "Ingredient name", 
						food_type: "Food type 1"
						})}

		it "has a quantity" do
			expect(recipe.quantities.new(ingredient: ingredient, quantity: 1, unit: 'units').quantity).not_to be(nil)
		end

		it "has a quantity of 1" do
			expect(recipe.quantities.new(ingredient: ingredient, quantity: 1, unit: 'units').quantity).to eq(1)
		end

		it "has a unit" do
			expect(recipe.quantities.new(ingredient: ingredient, quantity: 1, unit: 'units').unit).not_to be(nil)
		end

		it "has a unit of 'units'" do
			expect(recipe.quantities.new(ingredient: ingredient, quantity: 1, unit: 'units').unit).to eq('units')
		end
	end
end