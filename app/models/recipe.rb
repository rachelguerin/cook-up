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

      food_types = Ingredient.select(:food_type)
        .where(id:  
          Quantity.select(:ingredient_id)
          .where(recipe_id: recipe_ids)
          .where.not(ingredient_id: Ingredient.where(name: 'water').ids)
          .group(:ingredient_id).map{|i| i.ingredient_id})
        .group(:food_type)

      food_types.each do |f|
        ingredients = []
        ingredients_by_food_type = Ingredient.where(id:  
          Quantity.select(:ingredient_id)
          .where(recipe_id: recipe_ids)
          .group(:ingredient_id).map{|i| i.ingredient_id},food_type: f.food_type)

        ingredients_by_food_type.each do |i|
          total_qty = Quantity.where(recipe_id: recipe_ids, ingredient_id: i.id).sum(:quantity)
          unit = Quantity.where(ingredient_id: i.id).first.unit

          ingredients << {ingredient: i, quantity: total_qty, unit: unit}
        end
          shopping_list[f.food_type] = ingredients
      end

      shopping_list
    end
end
