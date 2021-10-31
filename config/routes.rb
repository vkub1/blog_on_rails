Rails.application.routes.draw do
  get('/', {to:'posts#index', as: :root})
  resources :posts do
    resources :comments, only:[:create, :destroy]
  end

  resources :users, only:[:new, :create, :edit, :update]

  get("/users/:id/edit/change_password", {to: "users#change_password", as: :change_password})
  patch("/user/:id/edit", {to: "users#update_password", as: :update_password})

  resource :session, only:[:new, :create, :destroy]
end
