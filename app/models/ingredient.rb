class Ingredient < ActiveRecord::Base
	# attr_accessible :name, :food_type, :auto_list
	has_many :quantities
	has_many :recipes, through: :quantities  
end
