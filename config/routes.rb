Rails.application.routes.draw do

  resources :pins do
    collection { post :import }
    member do  
      match 'sendrequest' => 'pins#sendrequest', :via => [:get, :post]  
    end 
  end  
  
  get :deleteAllImported, to: 'pins#deleteAllImported', as: :deleteAllImported
  get :deleteAll, to: 'pins#deleteAll', as: :deleteAll
  get :sendGroupOffers, to: 'pins#sendGroupOffers', as: :sendGroupOffers
  get :ExpireAllPendingOffers, to: 'pins#ExpireAllPendingOffers', as: :ExpireAllPendingOffers
  get :ExpireOffersPastExpireDate, to: 'pins#ExpireOffersPastExpireDate', as: :ExpireOffersPastExpireDate

  devise_for :users

  #root to: "pins#index"
  root to: "pages#home"

  get "about" => "pages#about"
  get "dashboard" => "pages#dashboard"
  get "team" => "pages#team"
  get "faqs" => "pages#FAQS"
  get "importinvoices" => "pins#index"
  get "pendingoffers" => "pins#pendingoffers"
  get "acceptedoffers" => "pins#acceptedoffers"
  get "offersreceived" => "pins#offersreceived"
  get "all_invoices" => "pins#all_invoices"
  get "acceptedoffersadmin" => "pins#acceptedoffersadmin"
  

  as :user do
  get 'offersreceived', :to => "pages#offersreceived", :as => :user_root # Rails 3
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
