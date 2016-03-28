Rails.application.routes.draw do
  root to: 'menus#home'
  
  resources :recipes, only: [:index, :show]

  get '/list/:menu' => 'shopping_list#list'

  get '/menus' => 'menus#search_recipes'

  post '/mail_shopping_list' => 'shopping_list#mail_shopping_list'

end
