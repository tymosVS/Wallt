Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :accounts, only: [:index, :new, :create, :destroy]
  resources :transactions, only: [:index, :new, :create]
  resources :users, controller: 'accounts', type: 'User'
  resources :stocks, controller: 'accounts', type: 'Stock'
  resources :teams, controller: 'accounts', type: 'Team'

  root 'accounts#index'
end
