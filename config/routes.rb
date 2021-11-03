Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
    sessions: 'public/user/sessions',
    registrations: 'public/user/registrations'
  }

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }
end
