Rails.application.routes.draw do
    # Routes
    get 'about', to: 'pages#about'
    

    # Defines the root path route ("/")
    root "pages#home"
end
