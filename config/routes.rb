Rails.application.routes.draw do
  # namespace :public do
  #   get 'addresses/index'
  #   get 'addresses/edit'
  #   get 'addresses/create'
  #   get 'addresses/update'
  #   get 'addresses/destroy'
  # end
  namespace :admin do
    resources :customers, only:[:index, :show, :edit, :update]
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
  end

  # デフォルトのルーティングは削除(参考：https://nllllll.com/ruby-on-rails/rails-devise/)
  # devise_for :admins
  # devise_for :customers

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # 管理者用
  # URL /admins/sign_in ...
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    get 'customers/unsubscribe' => "customers#unsubscribe", as: "unsubscribe"
    patch 'customers/withdrawal' => "customers#withdrawal", as: "withdrawal"
    get 'customers/' => 'customers#show', as: "customers_my_page"
    get 'customers/information' => 'customers#edit', as: "customer_edit"
    patch 'customers/information' => 'customers#update', as: "customers"
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: "destroy_all"
    post 'orders/confirm' => 'orders#confirm', as: "orders_confirm"
    get 'orders/thanks' => 'orders#thanks', as: "orders_thanks"
    get 'addresses/information' => 'addresses#edit', as: "address_edit"
    patch 'addresses/update' => 'addresses#update', as: "address_update"
    delete 'addresses/destroy' => 'addresses#destroy', as: "address_destroy"
    
    
    resources :items, only:[:index, :show]
    resources :cart_items, only:[:index, :update, :destroy, :create]
    resources :orders, only:[:new, :create, :index, :show]
    resources :addresses, only:[:index, :create]
  end
  
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/admin' => 'admin/homes#top'

  # get '/public/top' => 'public/homes#top'
end






# 以下、上記をまとめる前
#   namespace :admin do
#     resources :customers, only:[:index, :show, :edit, :update]
#   end
#   namespace :admin do
#     # get 'items/index'
#     # get 'items/new'
#     # get 'items/create'
#     # get 'items/show'
#     # get 'items/edit'
#     # get 'items/update'
#     resources :items, only:[:index, :new, :create, :show, :edit, :update]
#   end
#   namespace :admin do
#     # get 'genres/index'
#     # get 'genres/create'
#     # get 'genres/edit'
#     # get 'genres/update'
#     resources :genres, only:[:index, :create, :edit, :update]
#   end
#   # デフォルトのルーティングは削除(参考：https://nllllll.com/ruby-on-rails/rails-devise/)
#   # devise_for :admins
#   # devise_for :customers

#   # 顧客用
#   # URL /customers/sign_in ...
#   devise_for :customers,skip: [:passwords], controllers: {
#     registrations: "public/registrations",
#     sessions: "public/sessions"
#   }

#   # 管理者用
#   # URL /admins/sign_in ...
#   devise_for :admin,skip: [:registrations, :passwords], controllers: {
#     sessions: "admin/sessions"
#   }

#   scope module: :public do
#     # get 'customers/show'
#     # get 'customers/edit'
#     # get 'customers/update'
#     get 'customers/unsubscribe' => "customers#unsubscribe", as: "unsubscribe"
#     patch 'customers/withdrawal' => "customers#withdrawal", as: "withdrawal"
#     get 'customers/' => 'customers#show', as: "customers_my_page"
#     get 'customers/information/edit' => 'customers#edit', as: "customer_edit"
#     patch 'customers/information' => 'customers#update', as: "customers"
#   end

#   scope module: :public do
#     # get 'items/index'
#     # get 'items/show'
#     resources :items, only:[:index, :show]
#   end

#   scope module: :public do
#     # get 'cart_items/index'
#     # get 'cart_items/update'
#     # get 'cart_items/destroy'
#     # get 'cart_items/create'
#     delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: "destroy_all"
#     resources :cart_items, only:[:index, :update, :destroy, :create]
#   end

#   scope module: :public do
#     post 'orders/confirm' => 'orders#confirm', as: "orders_confirm"
#     get 'orders/thanks' => 'orders#thanks', as: "orders_thanks"
#     # get 'orders/show' => 'orders#show', as: "orders_show"
#     resources :orders, only:[:new, :create, :index, :show]
#   end

#   # get '/public/top' => 'public/homes#top'
#   root to: 'public/homes#top'
#   get 'about' => 'public/homes#about'
#   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
#   get '/admin' => 'admin/homes#top'
# end
