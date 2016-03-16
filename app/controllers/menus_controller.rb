class MenusController < ApplicationController

	def index
		@recipes = [
			Recipe.where("title like 'E%'").first,
			Recipe.where("title like 'T%'").first,
			Recipe.where("title like 'G%'").first,
			Recipe.where("title like 'H%'").last,
			Recipe.fifth
		]
	end
end
