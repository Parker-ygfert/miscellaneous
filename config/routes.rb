# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users
  resources :todo_lists, path: 'todo-lists', expect: :show
end
