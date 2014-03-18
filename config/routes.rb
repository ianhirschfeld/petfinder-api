PetfinderApi::Application.routes.draw do

  root to: 'static#home'

  resources :shelters, only: [:create]

  namespace :api do
    namespace :rest do
      namespace :v1 do
        resources :shelters, only: [:create]
      end
    end
  end

end
