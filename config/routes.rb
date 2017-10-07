Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :auth do
        post 'signup', to: 'users#create'
        post 'login', to: 'users#login'
      end
      resources :posts, only: [:create, :show, :index] do
        resources :comments, only: [:create, :show, :index]
      end
    end
  end

end
