class MenusController < ApplicationController

	def index
		@monday_recipe = Recipe.where("title like 'E%'").first
		@tuesday_recipe = Recipe.where("title like 'T%'").first
		@wednesday_recipe = Recipe.where("title like 'G%'").first
		@thursday_recipe = Recipe.where("title like 'H%'").last
		@friday_recipe = Recipe.fifth
	end
end
