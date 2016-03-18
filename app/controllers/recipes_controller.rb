class RecipesController < ApplicationController
	def index

	end

	def show
		@title = "cook-up"
		@recipe = Recipe.find(params[:id])
		@ingredients = @recipe.get_ingredients
	end

end
