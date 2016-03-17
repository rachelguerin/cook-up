class Ingredient < ActiveRecord::Base
	# attr_accessible :name, :food_type, :auto_list
	has_many :quantities
	has_many :recipes, through: :quantities  

	def self.get_ingredient(name, food_type)
		i = Ingredient.where(name: name).first
		if i == nil
			i = Ingredient.create(name: name, food_type: food_type, auto_list: true)
		end
		i
	end
end
