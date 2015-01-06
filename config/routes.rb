Rails.application.routes.draw do

  root 'pages#index'

  # About pages
  get    'about'      => 'pages#about'
  get    'mume'       => 'pages#mume'
  get    'history'    => 'pages#history'
  get    'contact'    => 'pages#contact'
  get    'signup'     => 'users#new'
  get    'login'      => 'sessions#new'
  post   'login'      => 'sessions#create'
  delete 'logout'     => 'sessions#destroy'

  resources :users, except: :destroy
  resources :accounts, only: :edit
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :topics, except: :destroy
  resources :topics do
    resources :comments, only: [:create, :edit, :update]
  end
  resources :logs, except: :destroy
  resources :logs do
    resources :comments, only: [:create, :edit, :update]
  end

  namespace :admin do
    root 'dashboard#index'
    resources :users
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
