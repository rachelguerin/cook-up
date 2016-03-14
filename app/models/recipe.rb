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
end
