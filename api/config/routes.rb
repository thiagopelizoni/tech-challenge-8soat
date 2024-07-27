Rails.application.routes.draw do
  root "categoria#index"

  resources :clientes do
    collection do
      get 'search'
    end
  end

  resources :produtos do
    collection do
      get 'search'
    end
  end

  resources :categorias do
    collection do
      get 'search'
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
