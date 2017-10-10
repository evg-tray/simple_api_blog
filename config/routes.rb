Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :auth do
        post 'signup', to: 'users#create'
        post 'login', to: 'users#login'
      end
      post 'upload-avatar', controller: 'auth/users'
      resources :posts, only: [:create, :show, :index] do
        resources :comments, only: [:create, :show, :index]
      end
      post 'reports/by_author', to: 'reports#by_author'
    end
  end
  root 'home#index'
end
