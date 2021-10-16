Rails.application.routes.draw do
  get('/', {to:'posts#index'})
  resources :posts, only: [:index]
end
