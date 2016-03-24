# Preview all emails at http://localhost:3000/rails/mailers/menu_mailer
class MenuMailerPreview < ActionMailer::Preview
	def shopping_list_preview
		sl = "{\"Pasta and Rice\":[\"0.5 cup tomato sauce\",\"0.5 tablespoon black beans\"],\"Meat\":[\"1.5 lb ground beef\",\"250 grams ground meat\"],\"Canned and Jarred\":[\"0.5 teaspoon chicken bouillon\",\"4 tablespoons chicken broth\"],\"Produce\":[\"1  onion\",\"1  aubergine\",\"3 teaspoon basil\",\"2 Tbsp garlic\",\"1  spring onion\",\"1  eggplant\",\"2 inches dried mushrooms\",\"300 grams tofu\",\"8  bell pepper\",\"2 clove garlic paste\",\"1  tomato\",\"10  okra\"],\"Seafood\":[\"7 tablespoons shrimps\"],\"?\":[\"1 tablespoon stachy solution\"],\"Spices and Seasonings\":[\"2 servings salt\",\"1  parsley\",\"2 serving salt and pepper\",\"2 teaspoon red pepper powder\"],\"Oil, Vinegar, Salad Dressing\":[\"0.5 cup bread crumbs\",\"2 servings corn oil\",\"2 servings balsamic vinegar\"],\"Ethnic Foods\":[\"1 tablespoon sesame oil\",\"2 tablespoon soy sauce\",\"2 tsp ginger\",\"10 tablespoons light soya sauce\",\"5 tablespoons oyster sauce\",\"0.5 teaspoon ginger paste\"],\"Baking\":[\"4 tablespoon sugar\"]}"
		MenuMailer.shopping_list("21,23,24,25,26","rachel.guerin23@gmail.com",sl)
	end
end
