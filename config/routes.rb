Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api, {format: 'json'} do
    resources :users, only: [:create, :update]
    post 'sessions', to: 'sessions#create'
    resources :plans, only: [:index, :show, :create, :update, :destroy] do
      resources :outlines, :details, only: [:index, :create, :update, :destroy]
      patch 'outlines', to: 'outlines#sort'
      patch 'details', to: 'details#sort'
    end
  end
end
