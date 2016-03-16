require 'rails_helper'

RSpec.describe Recipe do
	
	
	describe "Check fields" do
		let(:recipe) {Recipe.new({title: "Recipe title", 
						cook_time: 45, 
						servings: 4, 
						method: "cook it and eat it", 
						image_url:"https://spoonacular.com/recipeImages/Cheesy-Grits-Casserole-637663.jpg", 
						original_id: 123456})}

		it "has a title" do
			expect(recipe.title).not_to eq(nil)
		end

		it "has title 'Recipe title'" do
			expect(recipe.title).to eq("Recipe title")
		end

		it "has a cook time" do
			expect(recipe.cook_time).not_to eq(nil)
			expect(recipe.cook_time).not_to eq(0)
		end

		it "has cook_time 45" do
			expect(recipe.cook_time).to eq(45)
		end

		it "has servings" do
			expect(recipe.cook_time).not_to eq(nil)
			expect(recipe.cook_time).not_to eq(0)
		end

		it "has 4 servings" do
			expect(recipe.servings).to eq(4)
		end

		it "has a method" do
			expect(recipe.method).not_to eq(nil)
		end

		it "has method 'cook it and eat it'" do
			expect(recipe.method).to eq('cook it and eat it')
		end

		it "has an image url" do
			expect(recipe.image_url).not_to eq(nil)
		end

		it "has image url 'https://spoonacular.com/recipeImages/Cheesy-Grits-Casserole-637663.jpg'" do
			expect(recipe.image_url).to eq('https://spoonacular.com/recipeImages/Cheesy-Grits-Casserole-637663.jpg')
		end

		it "has an original id" do
			expect(recipe.original_id).not_to eq(nil)
			expect(recipe.original_id).not_to eq(0)
		end

		it "has original id 123456" do
			expect(recipe.original_id).to eq(123456)
		end
	end
end