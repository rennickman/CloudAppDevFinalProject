Rails.application.routes.draw do
    get 'users/profile'
        # Devise Auth Routes
        devise_for :users, controllers: {
            sessions: 'users/sessions',
            registrations: 'users/registrations'
        }

    # Routes for Writings
    resources :writings

    # Routes for Questions
    resources :questions do
        resources :comments
    end

    # About Page Route
    get 'about', to: 'pages#about'

    # User Profile Route
    get '/u/:id', to: 'users#profile', as: 'user'
      
    # Defines the root path route ("/")
    root "pages#home"
end
