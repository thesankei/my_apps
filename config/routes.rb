MyApps::Application.routes.draw do

  resources :places do
  resources :services 
    resources :reviews
  end


  resources :blogposts do
    resources :comments
  end


  get "home/index"
  get 'tags/:tag', to: 'blogposts#blogfeed', as: :tag
  
  match '/about',to: 'home#about'
  match '/careers',to: 'home#careers'
  match '/developer',to: 'home#developer'
  match '/contact',to: 'home#contact'
  match '/blogfeed',to: 'blogposts#blogfeed'
  
  authenticated :user do
    root :to => 'home#index'
  end
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  #Add this later :registrations => "registrations"
  
  resources :users do
    member do
      get :including, :outlets
    end
  end
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
  devise_scope :user do
    get "/", :to => "devise/sessions#new"
  end
  
   namespace :admin do
    match '/' => 'users#index'
    resources :users
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

 