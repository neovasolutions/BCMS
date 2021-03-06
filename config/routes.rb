ActionController::Routing::Routes.draw do |map|
  map.namespace('cms') {|cms| cms.content_blocks :image_lists }

  map.namespace('cms') {|cms| cms.content_blocks :article_contents }

  map.namespace('cms') {|cms| cms.content_blocks :news_contents }

  map.namespace('cms') {|cms| cms.content_blocks :highlight_contents }

  map.namespace('cms') {|cms| cms.content_blocks :highlight_headers }

  map.namespace('cms') {|cms| cms.content_blocks :newsheaders }

  map.connect "/mail", :controller => "custom", :action => "send_email_form"
  map.connect "/send_email", :controller => "custom", :action => "send_email"
  map.connect "/print", :controller => "custom", :action => "print_page"
  map.search 'search',:controller => "custom", :action => 'search'
  map.save_article 'save-article',:controller => "custom", :action => 'save_article'
  map.account_email_alert 'account-email-alert',:controller => "custom", :action => 'account_email_alert'
  map.save_email_alert 'save-email-alert',:controller => "custom", :action => 'save_account_email_alert'
  map.acc_subscription 'acc-subscription', :controller => "custom", :action => 'acc_subscription'
  map.save_account_subscription 'save-account-subscription',:controller => "custom", :action => 'save_account_subscription'
  map.save_account_password 'save-account-password' ,:controller => "custom", :action => 'save_account_password'
  map.show_account_information 'show-account-information' ,:controller => "custom", :action => 'show_account_information'
  map.save_account_information 'save-account-information' ,:controller => "custom", :action => 'save_account_information'
  map.show_state_list 'show-state-list' ,:controller => "custom", :action => 'show_state_list'
  map.global_search 'global-search' ,:controller => "custom", :action => 'global_search'
 # map.routes_for_bcms_event 
 # map.routes_for_bcms_news 
  map.routes_for_browser_cms

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
