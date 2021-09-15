Rails.application.routes.draw do
  root to:'homes#top'

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  namespace :admin do

    get "top" => "orders#index"

    resources :posts,only: [:index,:show,:destroy]
    resources :categories,only: [:index,:create,:edit,:update,:destroy]
    resources :users,only: [:index,:show,:edit,:update,:destroy] do
      get "users/users_show" => "users#users_show"
    end
    resources :inquiries,only: [:index,:show,:create]

  end


  scope module: "users" do
    resources :users,only: [:show,:edit,:update]do
    get "users/check" => "users#check"
    patch "users/out" => "users#out"
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end

    resources :posts do
      resource :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    resources :chats,only: [:index,:show,:create]

    resources :inquiries,only: [:show,:create]
    
    resources :chats, only: [:show, :create]

 end

end
