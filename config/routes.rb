Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :folders do
    resources :documents
  end
  resources :documents
  resources :users

  # Defines the root path route ("/")
  root "home#index"
end
