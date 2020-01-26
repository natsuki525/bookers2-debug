Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
      root :to => 'home#top'
  end
  get 'home/about' => 'home#about'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  end
end
