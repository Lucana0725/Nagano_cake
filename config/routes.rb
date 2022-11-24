Rails.application.routes.draw do
  namespace :admin do
    resources :customers, only:[:index, :show, :edit, :update]
  end
  namespace :admin do
    # get 'items/index'
    # get 'items/new'
    # get 'items/create'
    # get 'items/show'
    # get 'items/edit'
    # get 'items/update'
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
  end
  namespace :admin do
    # get 'genres/index'
    # get 'genres/create'
    # get 'genres/edit'
    # get 'genres/update'
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

  # get '/public/top' => 'public/homes#top'
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/admin' => 'admin/homes#top'
end
