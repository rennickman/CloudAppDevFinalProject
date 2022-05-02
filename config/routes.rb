Rails.application.routes.draw do
  resources :writings
  resources :questions
    # Routes
    get 'about', to: 'pages#about'
    

    # Defines the root path route ("/")
    root "pages#home"
end
