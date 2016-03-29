class Recipe < ActiveRecord::Base

	has_and_belongs_to_many :classifications
	has_many :quantities
	has_many :ingredients, through: :quantities  
	accepts_nested_attributes_for :quantities,
           :reject_if => :all_blank,
           :allow_destroy => true
  	accepts_nested_attributes_for :ingredients

  	def self.get_any_5
  		Recipe.order("RANDOM()").limit(5)
  	end

    def get_ingredients
      these_ingredients = []
      ingredients.each do |i|
        qty = quantities.where(ingredient: i).first.quantity
        unit = quantities.where(ingredient: i).first.unit
        these_ingredients << {name: i.name, quantity: qty, unit: unit, food_type: i.food_type}
      end
    
      these_ingredients

    end

    def self.get_recipes(params)
      if params[:cook_time].to_f > 0
        recipes = Recipe.where(cook_time: 0..params[:cook_time].to_f, 
                    servings: 0..params[:servings].to_f)
        if !params[:classifications].nil?      
          classifications = params[:classifications].map {|c| c.to_i}
          recipes = recipes.select {|r| r.classifications.ids & classifications == classifications }
        end
      else
        recipes = Recipe.order("RANDOM()").limit(20)
      end
      
      recipes

    end

    def self.get_shopping_list(menu)
      recipe_ids = menu.split(",").map { |s| s.to_i }
      shopping_list = {}

      food_types = Ingredient.get_food_types(recipe_ids)

      food_types.each do |f|
        ingredients = []
        ingredients_by_food_type = Ingredient.get_ingredients_by_food_type(recipe_ids,f.food_type)

        ingredients_by_food_type.each do |i|
          total_qty = Quantity.calculate_total(recipe_ids,i.id)
          unit = Quantity.get_unit(recipe_ids,i.id)

          ingredients << {ingredient: i, quantity: total_qty, unit: unit}
        end
          shopping_list[f.food_type] = ingredients
      end

      shopping_list
    end
end
