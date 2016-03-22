class ShoppingListController < ApplicationController
	def list
		condiments = ["Spices and Seasonings","Oil, Vinegar, Salad Dressing","Ethnic Foods","Condiments"]
		@shopping_list = Recipe.get_shopping_list(params[:menu])
		@shopping_list_condiments = @shopping_list.select do |k,v| 
			condiments.include?(k)
		end

		@shopping_list.select! do |k,v| 
			!condiments.include?(k)
		end
		
	end
end
