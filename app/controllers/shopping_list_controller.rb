class ShoppingListController < ApplicationController
	def list
		@shopping_list = Recipe.get_shopping_list(params[:menu])
	end
end
