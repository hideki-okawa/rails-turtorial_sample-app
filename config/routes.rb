Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  # rootにアクセスがきたらhomeページを表示する
  root 'static_pages#home'
  
  # "/help"にGETメソッドが来たときにhelpページ表示する
  get  '/help',    to: 'static_pages#help'
  
  get  '/about',   to: 'static_pages#about'
  
  get  '/contact', to: 'static_pages#contact'
  
  get  '/signup', to: 'users#new'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  get 'sessions/new'
  
  # Usersリソースの全てのアクション
  resources :users
  
  # アカウント有効用のリソースを追加
  resources :account_activations, only: [:edit]
  
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
  resources :microposts,          only: [:create, :destroy]
  
  resources :relationships,       only: [:create, :destroy]
end
