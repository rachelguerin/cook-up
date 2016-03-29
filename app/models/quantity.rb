class Quantity < ActiveRecord::Base
	# attr_accessible :quantity,
	# 			  :unit,
 #                  :ingredient,
 #                  :ingredient_attributes
	belongs_to :recipe
	belongs_to :ingredient
	accepts_nested_attributes_for :ingredient,
                                :reject_if => :all_blank

    scope :ingredient_for_recipes, -> (recipe_ids,ingredient_id) { (where(recipe_id: recipe_ids, ingredient_id: ingredient_id))}

    def self.calculate_total(recipe_ids,ingredient_id)
    	Quantity.ingredient_for_recipes(recipe_ids,ingredient_id).sum(:quantity)
    end

    def self.get_unit(recipe_ids,ingredient_id)
    	Quantity.ingredient_for_recipes(recipe_ids,ingredient_id).first.unit
    end

end
