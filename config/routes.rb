Rails.application.routes.draw do
  # RESTful routes for messages
  resources :messages

  # Contacts routes
  get '/contacts/:id' => 'contacts#show'
  post '/contacts' => 'contacts#create'
  delete '/contacts/:id' => 'contacts#destroy'

  # Authentication routes
  post 'authenticate' => 'auth#authenticate_for_jwt'
  post 'register' => 'auth#create_with_jwt'

  # Account routes
  get '/account-contacts' => 'accounts#account_contacts'
  get '/account/:id' => 'accounts#show'
  get '/my-account' => 'accounts#my_account'
  get '/accounts/search/:query' => 'accounts#search_accounts'
  post '/accounts' => 'accounts#create'
  post 'my-account' => 'accounts#update'
  put '/my-account' => 'accounts#update'
  patch '/my-account' => 'accounts#update'
  delete '/my-account' => 'accounts#destroy'



  # Additional message routes
  get '/messages/sender/:senderid/recipient/:recipientid' => 'messages#message_thread'
  get '/messages/sender/:senderid/recipient/:recipientid/latest' => 'messages#latest'

  # Home route
  root 'static#index'

  # Error routes
  get '*not_found', to: 'static#not_found'
  get '404' => "static#not_found"
  get '422', :to => "static#unacceptable"
  get '500', :to => "static#internal_error"


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


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
