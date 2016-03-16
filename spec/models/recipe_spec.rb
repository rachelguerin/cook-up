require 'rails_helper'

RSpec.describe Recipe do
	
	let(:recipe) {Recipe.new({title: "Recipe title", cook_time: 45, servings: 4, method: "cook it and eat it", image_url:"", original_id: 123456})}


	it "has a title" do
		expect(recipe.title).not_to eq(nil)
	end

	it "has title 'Recipe title'" do
		expect(recipe.title).to eq("Recipe title")
	end

end