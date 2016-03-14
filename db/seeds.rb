# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
seed_file = Rails.root.join('db', 'seeds', 'classifications.yml')
config = YAML::load_file(seed_file)
Classification.create!(config)

ingredients = []
seed_file = Rails.root.join('db', 'seeds', 'ingredients.yml')
config = YAML::load_file(seed_file)
Ingredient.create!(config) do |i|
	ingredients << i
end



seed_file = Rails.root.join('db', 'seeds', 'recipes.yml')
config = YAML::load_file(seed_file)
Recipe.create!(config) do |r|
	r.classifications << Classification.where("name like 'Nut%'").first

end

spag_bog = Recipe.where(title: 'Spag Bog').first
spag_bog_ingredients = [ { name: 'beef mince', quantity: 500, unit: 'grams'},
	{ name: 'onion', quantity: 1, unit: 'units'},
	{ name: 'garlic', quantity: 3, unit: 'cloves'},
	{ name: 'laurel', quantity: 1, unit: 'leaves'},
	{ name: 'salt', quantity: 1, unit: 'tsp'},
	{ name: 'pepper', quantity: 2, unit: 'shakes'},
	{ name: 'oregano', quantity: 5, unit: 'shakes'},
	{ name: 'tomato puree', quantity: 500, unit: 'ml'},
	{ name: 'mushroom', quantity: 5, unit: 'units'},
	{ name: 'green pepper', quantity: 1, unit: 'units'},
	{ name: 'carrot', quantity: 3, unit: 'units'}
]

spag_bog_ingredients.each do |i|
	spag_bog.quantities.create(
		ingredient_id: Ingredient.where(name: i[:name]).first.id,
		quantity: i[:quantity],
		unit: i[:unit]
	)
end



