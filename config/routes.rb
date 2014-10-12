SmwSmw::Application.routes.draw do


  root :to => 'home#index'

  match 'home/:id' => 'home#admin'

  match 'admin_edit_listing/:id' => 'listings#admin_edit'

  match 'listings_admin/:id' => 'listings#admin'


  match 'login' => 'user_sessions#new', :as => :login

  match 'logout' => 'user_sessions#destroy', :as => :logout


  # password_reset "password_reset", :controller => "password_resets", :action => "new"
  # whatitsworth "whatitsworth", :controller => "home", :action => "whatitsworth"


  match 'searchautos' => 'autolistings#searchautos', :as => :searchautos
  match 'searchmotos' => 'motolistings#searchmotos', :as => :searchmotos
  match 'searchmarine' => 'marinelistings#searchmarine', :as => :searchmarine
  match 'searchpower' => 'powerlistings#searchpower', :as => :searchpower

  match 'about' => 'home#about', :as => :about

  # matt_bio "matt_bio", :controller => "home", :action => "matt_bio"
  # daniel_bio "daniel_bio", :controller => "home", :action => "daniel_bio"

  match 'contact' => 'home#contact', :as => :contact

  match 'faq' => 'home#faq', :as => :faq

  match 'whatiwant' => 'whatiwant#whatiwant', :as => :whatiwant

  match 'basicsearch' => 'listings#basicsearch', :as => :basicsearch

  match 'newmain' => 'listings#newmain', :as => :newmain

  match 'newmain' => 'listings#newmain', :as => :newmain

  match 'photos/:id' => 'photos#showlarge', :as => :largephoto


  match 'medphoto/:id' => 'photos#showmedium', :as => :medphoto

  match 'smallphoto/:id' => 'photos#showsmall', :as => :smallphoto


  match 'inbox' => 'messages#inbox', :as => :inbox

  match 'sent' => 'messages#sent', :as => :sent

  resources :messages do
    member do
      delete 'deletesent'
      get 'reply'
    end
  end

  match 'privacypolicy' => 'home#privacypolicy', :as => :privacypolicy

  match 'visitoragreement' => 'home#visitoragreement', :as => :visitoragreement


  # forums "forums", :controller => :home, :action => :forums
  # autoemail "autoemail", :controller => :autoemail, :action => :index

   resources :wishlists
   resources :favorites
   resources :messages
   resources :users, :has_many=>:listings

   resources :listings do
    resources :photos
   end

   resources :user_sessions

   resources :users, :shallow => true do
    resources :listings, :name_prefix => nil do
      resources :photos
    end
    resources :wishlists
    resources :favorites
  end

   resources :password_resets
   resources :autocategories
   resources :automodels
   resources :marinecategories
   resources :marinemakes
   resources :motocategories
   resources :motomakes
   resources :powercategories
   resources :powermakes
   resources :autolistings
   resources :motolistings
   resources :marinelistings
   resources :powerlistings

   #connect ':controller/:action/:id'
   #connect ':controller/:action/:id.:format'




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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
