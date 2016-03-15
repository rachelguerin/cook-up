Rails.application.routes.draw do

  resources :menus, only: [:index, :show]
 
  get '/' => 'menus#index'
end
