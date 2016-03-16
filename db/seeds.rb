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

	c = a['classifications']
	c.each do |y|
		r.classifications << Classification.where(name: y).first
	end
end
