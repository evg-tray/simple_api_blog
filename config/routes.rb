Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :auth do
        post 'signup', to: 'users#create'
        post 'login', to: 'users#login'
      end

    end
  end

end
