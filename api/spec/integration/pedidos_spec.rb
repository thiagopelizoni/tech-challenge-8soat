require 'swagger_helper'

RSpec.describe 'Pedidos API', type: :request do
  path '/pedidos' do
    get 'Listar Pedidos' do
      parameter name: :page, in: :query, type: :integer, description: 'Número da página'
      parameter name: :per_page, in: :query, type: :integer, description: 'Número de itens por página'
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

  path '/pedidos/pronto' do
    get 'GET Pedidos Prontos' do
      tags 'Pedidos'
      produces 'application/json'

      response '200', 'pedidos found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   valor: { type: :number },
                   status: { type: :string },
                   observacao: { type: :string },
                   data: { type: :string, format: 'date' },
                   data_status: { type: :string, format: 'date' },
                   cliente: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       nome: { type: :string },
                       data_nascimento: { type: :string, format: 'date' },
                       cpf: { type: :string },
                       email: { type: :string }
                     }
                   },
                   produtos: {
                     type: :array,
                     items: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         nome: { type: :string },
                         descricao: { type: :string },
                         preco: { type: :number }
                       }
                     }
                   }
                 }
               }
        run_test!
      end
    end
  end

  path '/pedidos/recebido' do
    get 'GET Pedidos Recebidos' do
      tags 'Pedidos'
      produces 'application/json'

      response '200', 'pedidos found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   valor: { type: :number },
                   status: { type: :string },
                   observacao: { type: :string },
                   data: { type: :string, format: 'date' },
                   data_status: { type: :string, format: 'date' },
                   cliente: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       nome: { type: :string },
                       data_nascimento: { type: :string, format: 'date' },
                       cpf: { type: :string },
                       email: { type: :string }
                     }
                   },
                   produtos: {
                     type: :array,
                     items: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         nome: { type: :string },
                         descricao: { type: :string },
                         preco: { type: :number }
                       }
                     }
                   }
                 }
               }
        run_test!
      end
    end
  end

  path '/pedidos/em_preparacao' do
    get 'GET Pedidos em Preparação' do
      tags 'Pedidos'
      produces 'application/json'

      response '200', 'pedidos found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   valor: { type: :number },
                   status: { type: :string },
                   observacao: { type: :string },
                   data: { type: :string, format: 'date' },
                   data_status: { type: :string, format: 'date' },
                   cliente: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       nome: { type: :string },
                       data_nascimento: { type: :string, format: 'date' },
                       cpf: { type: :string },
                       email: { type: :string }
                     }
                   },
                   produtos: {
                     type: :array,
                     items: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         nome: { type: :string },
                         descricao: { type: :string },
                         preco: { type: :number }
                       }
                     }
                   }
                 }
               }
        run_test!
      end
    end
  end

  path '/pedidos/finalizado' do
    get 'GET Pedidos Finalizados' do
      tags 'Pedidos'
      produces 'application/json'

      response '200', 'pedidos found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   valor: { type: :number },
                   status: { type: :string },
                   observacao: { type: :string },
                   data: { type: :string, format: 'date' },
                   data_status: { type: :string, format: 'date' },
                   cliente: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       nome: { type: :string },
                       data_nascimento: { type: :string, format: 'date' },
                       cpf: { type: :string },
                       email: { type: :string }
                     }
                   },
                   produtos: {
                     type: :array,
                     items: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         nome: { type: :string },
                         descricao: { type: :string },
                         preco: { type: :number }
                       }
                     }
                   }
                 }
               }
        run_test!
      end
    end
  end

end