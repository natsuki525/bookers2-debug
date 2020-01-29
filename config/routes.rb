Rails.application.routes.draw do

  get 'rooms/show'
  devise_for :users
  devise_scope :user do
      root :to => 'home#top'
  end
  get 'home/about' => 'home#about'
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end
  resources :books do
  	resource :book_comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end

  resources :rooms

  get 'search/search'

end
