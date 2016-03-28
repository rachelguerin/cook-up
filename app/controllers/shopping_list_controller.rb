class ShoppingListController < ApplicationController
	def list
		condiments = ["Spices and Seasonings","Oil, Vinegar, Salad Dressing","Ethnic Foods","Condiments","Baking"]
		@shopping_list = Recipe.get_shopping_list(params[:menu])
		@shopping_list_condiments = @shopping_list.select do |k,v| 
			condiments.include?(k)
		end

		@shopping_list.select! do |k,v| 
			!condiments.include?(k)
		end
		@menu = params[:menu]
		@recipes = Recipe.where(id: @menu.split(",").map { |s| s.to_i })
		
	end

	def mail_shopping_list
		MenuMailer.shopping_list(params[:menu],params[:email],params[:shopping_list]).deliver_now
		redirect_to '/'
	end	
end
