require 'unirest'
# require 'pry'
require 'json'

ids = ["637663","638534","642293","662069","634582","638409","641893","647142",
	"657651","716627","665294","642546","636608","642540","646043","633711",
	"664553","642121","655573","643225","646051","649512","650112","663108",
	"639658","642929","716354","632807","632983","641123","638125","638086",
	"637876","627876","629963","634476","634891","636488","637999","638002"]

ids.uniq!

results = []
ids.each do |id|

	response = Unirest.get "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/"+id+"/information",
	  headers:{
	    "X-Mashape-Key" => "HlSoVMlxQOmshuOZuzLgKhXBfYTdp1PfjBCjsn69m9h0EsZe88"
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

	results << {recipe: recipe, ingredients: ingredients}
end

file = File.open("recipes_ingredients.json","w")
file.puts('{ "results": '+results.to_json+'}')
file.close	
