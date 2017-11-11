Rails.application.routes.draw do
  resources :recipes
  get '/recipes/:id/delete', to: 'recipes#destroy'
  root 'recipes#index'
end
