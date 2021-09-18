Rails.application.routes.draw do
  # get 'inquiry/index'
  # get 'inquiry/confirm'
  # get 'inquiry/thanks'
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

  namespace :admins do

    resources :posts,only: [:index,:show,:destroy]
    resources :categories,only: [:index,:create,:edit,:update,:destroy]
    resources :users,only: [:index,:show,:edit,:update] do
      get "check" => "users#check"
    end

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

    # root  'inquiry#index'
    get   'inquiries'         => 'inquiries#index'     # 入力画面
    post  'inquiries/confirm' => 'inquiries#confirm'   # 確認画面
    post  'inquiries/thanks'  => 'inquiries#thanks'    # 送信完了画面

 end

end
