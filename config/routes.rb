Rails.application.routes.draw do

  root 'chats#index'

  devise_for :users

  resources :mensajes, only: [:new, :create]
  resources :chats, only: [:index, :show]
  resources :users, only: [:index]

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
