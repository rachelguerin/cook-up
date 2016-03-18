Rails.application.routes.draw do

  resources :recipes, only: [:index, :show]
 
  get '/' => 'menus#home'

  get '/list' => 'shopping_list#list'

  post '/' => 'menus#search_recipes'

end
