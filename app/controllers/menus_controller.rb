class MenusController < ApplicationController
	def home
		@recipes = Recipe.get_any_5
		@classifications = Classification.all
		@days = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
	end

	def search_recipes
		@recipes = Recipe.get_recipes(params)
		render json: @recipes
	end

	private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.permit(:servings, :cook_time, :classifications)
    end
end
