require 'rails_helper'

RSpec.describe Ingredient do
	describe "check fields" do 
		let(:ingredient) {Ingredient.new({name: "Ingredient name", 
						food_type: "Food type 1"
						})}

		it "has a name" do
			expect(ingredient.name).not_to eq(nil)
		end

		it "has name 'Ingredient name'" do
			expect(ingredient.name).to eq("Ingredient name")
		end

		it "has a food type" do
			expect(ingredient.food_type).not_to eq(nil)
		end

		it "has food type 'Food type 1'" do
			expect(ingredient.food_type).to eq("Food type 1")
		end

	end

	describe "method get_ingredient" do
		it "returns existing ingredient if ingredient name/type exists" do
			Ingredient.new({name: "Ingredient 1", 
						food_type: "Food type 1"
						})
			expect(Ingredient.get_ingredient("Ingredient 1", "Food type 1").id).to eq(1)
		end

		it "returns new ingredient if ingredient doesn't exist" do
			Ingredient.new({name: "Ingredient 1", 
						food_type: "Food type 1"
						})
			expect(Ingredient.get_ingredient("Ingredient 2", "Food type 1").id).to_not eq(1)
		end
	end
end