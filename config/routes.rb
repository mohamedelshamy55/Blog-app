Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: 'users#index'
  resources :users, only: %i[show index] do
  resources :posts, only: %i[index create new show]
  end
  resources :posts do
    resources :comments, only: %i[create new]
    resources :likes, only: %i[create]
  end
end


# root 'users#index' resources :users, only: [:index, :show] do resources :posts, only: [:index, :show] end 