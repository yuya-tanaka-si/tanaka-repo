Rails.application.routes.draw do
  resources :users
  post "/users/search"
end
