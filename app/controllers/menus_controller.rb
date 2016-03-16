class MenusController < ApplicationController

	def index
		@recipes = Recipe.get_any_5

	end

	def show

	end
end
