class MenuMailer < ApplicationMailer
	def shopping_list(menu,email,shopping_list)
		recipe_ids = menu.split(",").map { |s| s.to_i }

		@email = email
		@recipes = Recipe.where(id: recipe_ids)
		@shopping_list = JSON.parse(shopping_list)

		@url = "http://cook-up.eu"
		mail(to: @email, subject: 'Your weekly shopping list from cook-up')
	end
end
