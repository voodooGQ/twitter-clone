# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/new'

  root "static_pages#home"

  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"
  get "feed", to: "feed#index", as: "feed"

  resources :users
  resources :sessions
  resources :chirps
  resources :likes
  resources :user_relationships
end
