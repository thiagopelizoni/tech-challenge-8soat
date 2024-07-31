Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root "categorias#index"
  
  resources :pedidos do
    collection do
      get 'search', to: 'pedidos#search'
      get 'pronto', to: 'pedidos#pronto'
      get 'recebido', to: 'pedidos#recebido'
      get 'em-preparacao', to: 'pedidos#em_preparacao'
      get 'finalizado', to: 'pedidos#finalizado'
      get 'pago', to: 'pedidos#pago'
      get 'em-aberto', to: 'pedidos#em_aberto'
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
