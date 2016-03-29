class Ingredient < ActiveRecord::Base
	# attr_accessible :name, :food_type, :auto_list
	has_many :quantities
	has_many :recipes, through: :quantities  

	scope :water, -> { (where(name: 'water').ids)}

	def self.get_ingredient(name, food_type)
		i = Ingredient.where(name: name).first
		i = Ingredient.create(name: name, food_type: food_type) if i.nil?
		i
	end

	def self.get_food_types(recipe_ids)
		Ingredient.select(:food_type)
        .where(id:  
          Quantity.where(recipe_id: recipe_ids)
          .where.not(ingredient_id: water)
          .pluck(:ingredient_id).uniq!)
        .group(:food_type)
	end

	def self.get_ingredients_by_food_type(recipe_ids,food_type)
		Ingredient.where(id:  
          Quantity.where(recipe_id: recipe_ids)
          .pluck(:ingredient_id).uniq!,
        food_type: food_type)
	end
end
