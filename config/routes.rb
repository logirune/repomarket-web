Rails.application.routes.draw do

    devise_for :users, :controllers => { :registrations => 'registrations',:omniauth_callbacks => "callbacks" },path_names: { sign_in: ''}

    root 'pages#index'

    get '/language/(:language)/framework/(:framework)/category/(:category)', to:'products#browse', as: '/browse'

    get '/product/(:slug)', to:'products#show', as: '/product/show'
    get '/product/buy/(:slug)', to:'products#buy', as: '/product/buy'
    get '/product/download/(:slug)', to:'products#download', as: '/product/download'
    get '/product/download/register/(:slug)', to:'products#register_download', as: '/product/download/register'
    post '/product/buy/(:slug)', to:'charges#create'


    get '/about', to:'pages#about'
    get '/become-seller', to:'pages#become_seller'
    get '/legal/privacy_policies', to:'pages#privacy_policies'
    get '/legal/terms_of_services', to:'pages#terms_of_services'

    resources :charges

    namespace :account do

        root 'dashboard#index'
        get '/dashboard', to: 'dashboard#index'

        # Profile
        get '/profile', to: 'profile#index'
        post '/profile', to: 'profile#update'

        # Settings
        get '/settings', to: 'settings#index'
        get '/settings/activate-seller', to: 'settings#activate_seller', as: '/settings/activate-seller'

        # Payment
        get '/payment/stripe_autorize'
        get '/payment/stripe_deautorize'
        get '/payment/stripe_callback'

        get '/settings/github_deautorize'
        get '/settings/github_autorize'

        # Products
        resources :products, except: [:show,:new]
        get 'products/repositories/', to: 'products#repositories', as: 'products/repositories'
        get 'products/import/(:repo_id)', to: 'products#import_github', as: 'products/import'
        get 'product/remove_screenshot/(:id)/(:signed_id)', to: "products#delete_screenshot", as: "product/remove_screenshot"
        get 'products/list_frameworks/(:language_id)', to: "products#list_frameworks", as: 'products/list_frameworks'

        # Purchases
        get '/purchases', to: 'purchases#index'
        get '/purchases/view/(:id)', to: "purchases#view", as:'purchases/view'
        get '/purchases/receipt/(:id)', to: "purchases#receipt", as:'purchases/receipt'

        # Sales
        get '/sales', to: 'sales#index'
        get '/sales/view/(:id)', to: "sales#view", as:'sales/view'

    end

end
