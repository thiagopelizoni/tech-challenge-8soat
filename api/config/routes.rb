Rails.application.routes.draw do
  resources :clientes

  resources :produtos do
    collection do
      get 'search'
    end
  end

  resources :categorias

  resources :categorias do
    resources :produtos do
      collection do
        get 'search'
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "produtos#index"
end
