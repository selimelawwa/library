Rails.application.routes.draw do
  resources :books
  resources :users
  
 resources :order_items, only: [:create, :update, :destroy]
  
  resources :orders, only: [:index, :show, :destroy]

  root 'welcome#index'

 get 'search', to: 'search#index'
  
  
  get 'login', to: 'sessions#new'
  post 'login', to:  'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
