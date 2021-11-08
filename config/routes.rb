Rails.application.routes.draw do

# ユーザー側
  devise_for :user,skip: [:passwords], controllers: {
    sessions: 'public/user/sessions',
    registrations: 'public/user/registrations'
  }
# ログアウトができないため、下記記述した
  devise_scope :user do
    get '/user/sign_out' => 'devise/sessions#destroy'
  end

  scope module: :public do
    root 'homes#top'
    get 'homes/about' => 'homes#about'
    get 'users/myindex' => 'users#myindex'
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      member do
        get :favorites
      end
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    get 'articles/:id/maps' => 'articles#maps'
    get 'articles/timeline' => 'articles#timeline'
    resources :articles, only: [:index, :new, :show, :edit, :create, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
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
