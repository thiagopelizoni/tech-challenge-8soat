Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root "categorias#index"

  post 'webhooks/mercado-pago', to: 'webhooks#mercado_pago'
  
  resources :pedidos do
    collection do
      get 'search', to: 'pedidos#search'
      get 'prontos', to: 'pedidos#prontos'
      get 'recebidos', to: 'pedidos#recebidos'
      get 'em-preparacao', to: 'pedidos#em_preparacao'
      get 'finalizados', to: 'pedidos#finalizados'
      get 'pagamento-confirmado', to: 'pedidos#pagamento_confirmado'
      get 'pagamento-em-aberto', to: 'pedidos#pagamento_em_aberto'
      get 'pagamento-recusado', to: 'pedidos#pagamento_recusado'
    end

    member do
      put 'pagar', to: 'pedidos#pagar'
      put 'receber', to: 'pedidos#receber'
      put 'preparar', to: 'pedidos#preparar'
      put 'pronto', to: 'pedidos#pronto'
      put 'finalizar', to: 'pedidos#finalizar'
      get 'qr-code', to: 'pedidos#qr_code'
    end
  end

  resources :clientes do
    collection do
      get 'nome/:nome', to: 'clientes#search_by_nome', as: :search_by_nome
      get 'email/:email', to: 'clientes#search_by_email', as: :search_by_email
      get 'cpf/:cpf', to: 'clientes#search_by_cpf', as: :search_by_cpf
      get 'data_nascimento/:data_nascimento', to: 'clientes#search_by_data_nascimento', as: :search_by_data_nascimento
    end
  end

  resources :produtos do
    collection do
      get 'nome/:nome', to: 'produtos#search_by_nome', as: :search_produtos_by_nome
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
