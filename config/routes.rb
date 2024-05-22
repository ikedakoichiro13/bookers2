Rails.application.routes.draw do
  resources :user, only: [:show, :edit]
  resources :book, only: [:index, :new, :show]
  root to: 'homes#top'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
