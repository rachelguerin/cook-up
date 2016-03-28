require 'rails_helper'
require 'spec_helper'

feature 'User searches for a weekly menu' do
	let(:r2) {Recipe.create(title: "Recipe 1",
						cook_time: rand(120), 
						servings: rand(8), 
						method: "1 cook it and eat it", 
						image_url:"https://spoonacular.com/recipeImages/Cheesy-Grits-Casserole-637663.jpg", 
						original_id: rand(999999),
						source_url: "https://thisisthesourceurl"
					)}

	scenario 'opens home' do
	    visit '/'

	    expect(page).to have_content('your weekly menu')
  	end

  	scenario 'opens recipe page' do


  		visit '/recipes/'+r2.id.to_s

  		expect(page).to have_content('Recipe 1')
  	end

  	scenario 'navigates home from recipe page' do
  		visit '/recipes/'+r2.id.to_s
  		click_link('cook-up')

  		expect(page).to have_content('your weekly menu')
  	end

	# scenario 'with no time, a couple, no diet restrictions' do
	#     visit '/'
	#     click_link('make_menu')

	#     expect(page).to have_content('How much time do you have to cook?')
 #  	end

 #  	scenario 'with no time, a couple, no diet restrictions' do
	#     visit '/'

	#     expect(page).not_to have_content('How much time do you have to cook?')
 #  	end
end
