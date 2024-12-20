Rails.application.routes.draw do
  root "articles#index"

  # Rotas para login/logout
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  resources :comments

  resources :users do
    resources :articles
    collection do
      get :admin
    end
    member do
      get :edit_user_type #mesmo nome que tem no controller
      patch :update_user_type #é o mesmo nome chamado no controlador
    end
  end
  
  resources :articles do
    resources :comments
  end
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
