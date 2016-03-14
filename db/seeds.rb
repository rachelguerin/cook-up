# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

seed_file = Rails.root.join('db', 'seeds', 'recipes.yml')
config = YAML::load_file(seed_file)
Recipe.create!(config)

seed_file = Rails.root.join('db', 'seeds', 'classifications.yml')
config = YAML::load_file(seed_file)
Classification.create!(config)