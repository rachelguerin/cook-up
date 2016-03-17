class RecipesController < ApplicationController
	def index
		@recipes = Recipe.get_any_5
		@title = ""
	end

	def show
		@title = "cook-up"
		@recipe = Recipe.find(params[:id])
		@ingredients = @recipe.get_ingredients
	end

end
