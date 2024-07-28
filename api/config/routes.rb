Rails.application.routes.draw do
  root "categorias#index"
  
  resources :pedidos do
    collection do
      get 'search'
    end
  end  

  resources :clientes do
    collection do
      get 'search'
    end
  end

  resources :produtos do
    collection do
      get 'search'
      get 'ativos'
      get 'inativos'
    end
  end

  resources :categorias do
    collection do
      get 'search'
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
