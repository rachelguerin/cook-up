Rails.application.routes.draw do

  resources :recipes, only: [:index, :show]
 
  get '/' => 'recipes#index'

end
