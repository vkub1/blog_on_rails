Rails.application.routes.draw do
  get('/', {to:'posts#index', as: :root})
  resources :posts, only: [:index, :new]
end
