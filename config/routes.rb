Rails.application.routes.draw do
  resources :books
  resources :users
  
 resources :order_items, only: [:create, :update, :destroy]
  
  resources :orders, only: [:index, :show, :destroy]
  resources :categories

  root 'welcome#index'

 get 'search', to: 'search#index'
  get 'bookstock', to: 'books#stock'
  
  get 'login', to: 'sessions#new'
  post 'login', to:  'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'allorders', to:'orders#all'
  get 'checkout', to: 'orders#checkout'

  get 'fetch_itmes' => 'search#from_category', as: 'fetch_items'

  post 'books/:id/rate', to: 'books#rate'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
