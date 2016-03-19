class Recipe < ActiveRecord::Base
	# attr_accessible :title,
 #                  :prep_time,
 #                  :cook_time,
 #                  :servings,
 #                  :method,
 #                  :quantities_attributes
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
binding.pry
      recipes = Recipe.where(cook_time: 0..params[:cook_time].to_f, 
                    servings: 0..params[:servings].to_f)

      if !params[:classifications].nil?
        classifications = params[:classifications].map {|c| c.to_i}
        recipes.select! {|r| r.classifications.ids & classifications == classifications }
      end

      recipes

    end
end
