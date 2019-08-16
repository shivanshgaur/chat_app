Rails.application.routes.draw do
  root controller: :rooms, action: :index
  resources :rooms, only: [:show, :index]
  resources :room_messages, only: [:create]
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
