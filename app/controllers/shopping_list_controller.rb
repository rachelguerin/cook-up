class ShoppingListController < ApplicationController
	def list
		@title = "cook-up"
		@shopping_list = Recipe.get_shopping_list(params[:menu])
	end
end
