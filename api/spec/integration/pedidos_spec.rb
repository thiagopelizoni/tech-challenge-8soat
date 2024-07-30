require 'swagger_helper'

RSpec.describe 'Pedidos API', type: :request do
  path '/pedidos' do
    get 'Listar Pedidos' do
      tags 'Pedidos'
      produces 'application/json'
      
      response '200', 'pedidos found' do
        run_test!
      end
    end
  end

  path '/pedidos/{id}' do
    get 'GET Pedido' do
      tags 'Pedidos'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'pedido found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            valor: { type: :number },
            status: { type: :string },
            observacao: { type: :string },
            data: { type: :string, format: 'date' },
            data_status: { type: :string, format: 'date' }
          },
          required: [ 'id', 'valor', 'status', 'observacao', 'data', 'data_status' ]

        let(:id) { Pedido.create!(valor: 10.0, status: 'recebido', observacao: 'test').id }
        run_test!
      end

      response '404', 'pedido not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/pedidos/search' do
    get 'Relatório de Pediso' do
      tags 'Pedidos'
      produces 'application/json'
      parameter name: :cpf, in: :query, type: :string
      parameter name: :cliente_nulo, in: :query, type: :boolean
      parameter name: :status, in: :query, type: :string

      response '200', 'search results' do
        run_test!
      end
    end
  end
end