Rails.application.routes.draw do
  
# ユーザー側
  devise_for :users,skip: [:passwords], controllers: {
    sessions: 'public/user/sessions',
    registrations: 'public/user/registrations'
  }
  
  scope module: :public do
    root 'homes#top'
    get 'homes/about' => 'homes#about'
    get 'users/myindex' => 'users#myindex'
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    
    get 'articles/:id/maps' => 'articles#maps'
    get 'articles/timeline' => 'articles#timeline'
    resources :articles, only: [:index, :new, :show, :edit, :create, :update, :destroy] do
      resource :favorites, only: [:create, :destroy, :index]
      resources :comments, only: [:create, :destroy]
    end
    
  end

# 管理者側
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'users' => 'users#index'
    resources :tags, only: [:index, :edit, :create, :update, :destroy]
  end
end
