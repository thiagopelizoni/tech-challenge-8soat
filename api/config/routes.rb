Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root "categorias#index"
  
  resources :pedidos do
    collection do
      get 'search'
      get 'pronto', to: 'pedidos#pronto'
      get 'recebido', to: 'pedidos#recebido'
      get 'em_preparacao', to: 'pedidos#em_preparacao'
      get 'finalizado', to: 'pedidos#finalizado'
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
