require 'rails_helper'

RSpec.describe Recipe do
		
	describe "Check fields" do 
		let(:recipe) {Recipe.new({title: "Recipe title", 
						cook_time: 45, 
						servings: 4, 
						method: "cook it and eat it", 
						image_url:"https://spoonacular.com/recipeImages/Cheesy-Grits-Casserole-637663.jpg", 
						original_id: 123456,
						source_url: "https://thisisthesourceurl"
						})}

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

	describe "retrieving recipes" do

		let(:r2) {Recipe.create(title: "Recipe 1",
							cook_time: rand(120), 
							servings: rand(8), 
							method: "1 cook it and eat it", 
							image_url:"https://spoonacular.com/recipeImages/Cheesy-Grits-Casserole-637663.jpg", 
							original_id: rand(999999),
							source_url: "https://thisisthesourceurl"
						)}
		let(:i1) {Ingredient.create(name: "1 ingredient",
							food_type: "#{rand(4)} type"
						)}

		it "returns 5" do
			5.times.each {Recipe.create(title: "Recipe 1",
							cook_time: rand(120), 
							servings: rand(8), 
							method: "1 cook it and eat it", 
							image_url:"https://spoonacular.com/recipeImages/Cheesy-Grits-Casserole-637663.jpg", 
							original_id: rand(999999),
							source_url: "https://thisisthesourceurl"
						)}
			expect(Recipe.get_any_5.count).to eq(5)
		end

 		it "gets ingredients" do		
 			r2.quantities.create(ingredient: i1, quantity: 1, unit: 'units')
 			expect(r2.get_ingredients.count).to be > 0
 		end

 		it "contains name" do
 			r2.quantities.create(ingredient: i1, quantity: 1, unit: 'units')
 			expect(r2.get_ingredients.first[:name]).not_to be(nil)
 		end

 		it "contains food_type" do
 			r2.quantities.create(ingredient: i1, quantity: 1, unit: 'units')
 			expect(r2.get_ingredients.first[:food_type]).not_to be(nil)
 		end

 		it "contains quantity" do
 			r2.quantities.create(ingredient: i1, quantity: 1, unit: 'units')
 			expect(r2.get_ingredients.first[:quantity]).not_to be(nil)
 		end

 		it "contains unit" do
 			r2.quantities.create(ingredient: i1, quantity: 1, unit: 'units')
 			expect(r2.get_ingredients.first[:unit]).not_to be(nil)
 		end

	end

	describe "returns recipes within search parameters" do
		before :each do 
			25.times.each {Recipe.create(title: "Recipe 1",
							cook_time: rand(120), 
							servings: rand(8), 
							method: "1 cook it and eat it", 
							image_url:"https://spoonacular.com/recipeImages/Cheesy-Grits-Casserole-637663.jpg", 
							original_id: rand(999999),
							source_url: "https://thisisthesourceurl"
						)}	
		end
		
		it "finds cook_time 45" do		
			expect(Recipe.get_recipes({cook_time: 45,servings: 3}).first.cook_time).to be <= 45
		end
		it "finds cook_time 90" do	
			expect(Recipe.get_recipes({cook_time: 90,servings: 3}).first.cook_time).to be <= 90
		end
		it "finds cook_time 120" do	
			expect(Recipe.get_recipes({cook_time: 120,servings: 3}).first.cook_time).to be <= 120
		end
		it "finds servings 3" do	
			expect(Recipe.get_recipes({cook_time: 45,servings: 3}).first.servings).to be <= 3
		end
		it "finds servings 6" do	
			expect(Recipe.get_recipes({cook_time: 45,servings: 6}).first.servings).to be <= 6
		end
		it "finds servings 10" do	
			expect(Recipe.get_recipes({cook_time: 45,servings: 10}).first.servings).to be <= 10
		end

	end

	describe "get_shopping_list" do
		it "returns all shopping list items by food type" do
			5.times.each {Recipe.create(title: "Recipe",
							cook_time: rand(120), 
							servings: rand(8), 
							method: "1 cook it and eat it", 
							image_url:"https://spoonacular.com/recipeImages/Cheesy-Grits-Casserole-637663.jpg", 
							original_id: rand(999999),
							source_url: "https://thisisthesourceurl"
						)}
			(0..2).each {|i| Ingredient.create(name: "Ingredient #{i}",
							food_type: "1 type"
						)}
			(0..2).each {|i| Ingredient.create(name: "Ingredient #{i}",
							food_type: "2 type"
						)}

			Recipe.first.quantities.create(ingredient: Ingredient.first, quantity: 1, unit: 'units')
			Recipe.first.quantities.create(ingredient: Ingredient.second, quantity: 1, unit: 'units')
			
			Recipe.second.quantities.create(ingredient: Ingredient.second, quantity: 1, unit: 'units')
			Recipe.second.quantities.create(ingredient: Ingredient.third, quantity: 1, unit: 'units')
			
			Recipe.third.quantities.create(ingredient: Ingredient.third, quantity: 1, unit: 'units')
			Recipe.third.quantities.create(ingredient: Ingredient.fourth, quantity: 1, unit: 'units')
			
			Recipe.fourth.quantities.create(ingredient: Ingredient.fourth, quantity: 1, unit: 'units')
			Recipe.fourth.quantities.create(ingredient: Ingredient.first, quantity: 1, unit: 'units')

			menus = Recipe.first.id.to_s + "," + Recipe.second.id.to_s + "," + Recipe.third.id.to_s + "," + Recipe.fourth.id.to_s
	
			expect(Recipe.get_shopping_list(menus)["1 type"].first[:quantity]).to be(2.0)
			expect(Recipe.get_shopping_list(menus)["2 type"].first[:quantity]).to be(2.0)
			
		end
	end
end