require 'unirest'
require 'pry'
require 'json'

url = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/"
recipe_path = "findByIngredients?ingredients="

key = "HlSoVMlxQOmshuOZuzLgKhXBfYTdp1PfjBCjsn69m9h0EsZe88"

searches = ["ground+beef","eggplant","tomato","chicken","chickpeas"]

rest = "&limitLicense=true&number=20&ranking=1"

ids = []

searches.each do |ingredient|
	response = Unirest.get url+recipe_path+ingredient+rest,
	  headers:{
	    "X-Mashape-Key" => key,
	    "Accept" => "application/json"
	  }


	response.body.each do |r|
		ids << r["id"]
	end
end

results = []
ids.each do |id|

	response = Unirest.get url+id.to_s+"/information",
	  headers:{
	    "X-Mashape-Key" => key
	  }

	recipe = {}

	recipe[:title] = response.body['title']  
	recipe[:cook_time] = response.body['readyInMinutes']  
	recipe[:servings] = response.body['servings']
	recipe[:method] = response.body['instructions']
	recipe[:image_url] = response.body['image']  
	recipe[:original_id] = response.body['id']
	recipe[:source_url] = response.body['sourceUrl']

	ingredients = []

	response.body['extendedIngredients'].each do |i|
		ingredient = {}
		ingredient[:name] = i['name']
		ingredient[:food_type] = i['aisle']
		ingredient[:quantity] = i['amount'].to_f
		ingredient[:unit] = i['unit']
		ingredients << ingredient
	end

	classifications = []

	if response.body['vegan'] 
		classifications << 'Vegetarian'
		classifications << 'Vegan'
	elsif response.body['vegetarian']
		classifications << 'Vegetarian'
	end

	if response.body['glutenFree'] 
		classifications << 'Gluten-Free' 
	end 

	if response.body['dairyFree']
		classifications << 'Dairy-Free' 
	end
		

	results << {recipe: recipe, ingredients: ingredients, classifications: classifications}
end

file = File.open("recipes_ingredients.json","w")
file.puts('{ "results": '+results.to_json+'}')
file.close	
