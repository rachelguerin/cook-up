# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# seed_file = Rails.root.join('db', 'seeds', 'classifications.yml')
# config = YAML::load_file(seed_file)
# Classification.create!(config)

json = ActiveSupport::JSON.decode(File.read('db/seeds/classifications.json'))

json.each do |a|
  Classification.create!(a)
end

recipes = ActiveSupport::JSON.decode(File.read('db/seeds/recipes_ingredients.json'))

def get_ingredient(name, food_type)
	i = Ingredient.where(name: name).first
	if i == nil
		i = Ingredient.create(name: name, food_type: food_type, auto_list: true)
	end
	return i
end

recipes['results'].each do |a|
	r = Recipe.create!(a['recipe']) 
	i = a['ingredients']
	i.each do |x|
		r.quantities.create(
			ingredient: get_ingredient(x['name'],x['food_type']),
			quantity: x['quantity'],
			unit: x['unit']
			)
	end
end



# ingredients = []
# seed_file = Rails.root.join('db', 'seeds', 'ingredients.yml')
# config = YAML::load_file(seed_file)
# Ingredient.create!(config) do |i|
# 	ingredients << i
# end



# seed_file = Rails.root.join('db', 'seeds', 'recipes.yml')
# config = YAML::load_file(seed_file)
# Recipe.create!(config) do |r|
# 	r.classifications << Classification.where("name like 'Nut%'").first

# end

# spag_bog = Recipe.where(title: 'Spag Bog').first
# spag_bog_ingredients = [ { name: 'beef mince', quantity: 500, unit: 'grams'},
# 	{ name: 'onion', quantity: 1, unit: 'units'},
# 	{ name: 'garlic', quantity: 3, unit: 'cloves'},
# 	{ name: 'laurel', quantity: 1, unit: 'leaves'},
# 	{ name: 'salt', quantity: 1, unit: 'tsp'},
# 	{ name: 'pepper', quantity: 2, unit: 'shakes'},
# 	{ name: 'oregano', quantity: 5, unit: 'shakes'},
# 	{ name: 'tomato puree', quantity: 500, unit: 'ml'},
# 	{ name: 'mushroom', quantity: 5, unit: 'units'},
# 	{ name: 'green pepper', quantity: 1, unit: 'units'},
# 	{ name: 'carrot', quantity: 3, unit: 'units'}
# ]

# spag_bog_ingredients.each do |i|
# 	spag_bog.quantities.create(
# 		ingredient_id: Ingredient.where(name: i[:name]).first.id,
# 		quantity: i[:quantity],
# 		unit: i[:unit]
# 	)
# end

# pineapple_pieces = Recipe.create(
# 	title: 'Pineapple Pieces', 
# 	prep_time: 1, 
# 	cook_time: 0, 
# 	servings: 2,
# 	method: 'Open can, pour into dish, eat. Can also eat directly from can.',
# 	image_url: 'http://example.com' 
# 	)

# pineapple_pieces.quantities.create(
# 	ingredient: Ingredient.create(name: 'pineapple', food_type: 'fruit', auto_list: true),
# 	quantity: 1,
# 	unit: 'can'
# 	)

# recipe = {
# 	title: 'Spaghetti Pesto', 
# 	prep_time: 1,
# 	cook_time: 10,
# 	servings: 2,
# 	method: 'Cook pasta. Add pesto sauce. Eat.',
# 	image_url: 'this is the image url',
# 	quantities_attributes: [{
# 		ingredient: Ingredient.create(name: 'spaghetti', food_type: 'pasta', auto_list: true),
# 		quantity: 100,
# 		unit: 'grams'
# 	},
# 	{
# 		ingredient: Ingredient.create(name: 'pesto', food_type: 'sauce', auto_list: true),
# 		quantity: 2,
# 		unit: 'tbsp'
# 	}
# ]
# }

