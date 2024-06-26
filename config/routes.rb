Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "/home/about" => "homes#about"
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
