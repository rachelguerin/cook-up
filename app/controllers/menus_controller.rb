class MenusController < ApplicationController
	def home
		@recipes = Recipe.get_any_5
		@title = ""
	end

end
