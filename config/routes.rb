Rails.application.routes.draw do
    # Devise Auth Routes
    devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
    }

    # Routes for Writings
    resources :writings

    # Routes for Questions
    resources :questions

    # About Page Route
    get 'about', to: 'pages#about'
    
    # Defines the root path route ("/")
    root "pages#home"
end
