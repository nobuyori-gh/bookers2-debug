Rails.application.routes.draw do

  get 'book_comments/create'
  get 'book_comments/destroy'
  devise_for :users


  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create,:destroy]
      # フォロー一覧
      get :follows, on: :member
      # フォロワー一覧
      get :followers, on: :member
  end

  resources :books do
  	resource :favorites, only: [:create, :destroy]
    resources :book_comments,only: [:create,:destroy]
  end

  root 'home#top'
  get 'home/about'
end