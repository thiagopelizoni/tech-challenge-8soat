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
            status: { type: :string,  enum: ['recebido', 'em_preparacao', 'pronto', 'finalizado'] },
            observacao: { type: :string },
            data: { type: :string, format: 'date' },
            data_status: { type: :string, format: 'date' },
            pagamento: { type: :string, enum: ['efetuado', 'em_aberto'] }
          },
          required: [ 'id', 'valor', 'status', 'observacao', 'data', 'data_status', 'pagamento' ]

        let(:id) { Pedido.create!(valor: 10.0, status: 'recebido', observacao: 'test', pagamento: 'em_aberto').id }
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
      parameter name: :page, in: :query, type: :integer, description: 'Número da página'
      parameter name: :per_page, in: :query, type: :integer, description: 'Número de itens por página'
      tags 'Pedidos'
      produces 'application/json'

      response '200', 'pedidos found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   valor: { type: :number },
                   status: { type: :string,  enum: ['recebido', 'em_preparacao', 'pronto', 'finalizado'] },
                   observacao: { type: :string },
                   data: { type: :string, format: 'date' },
                   data_status: { type: :string, format: 'date' },
                   pagamento: { type: :string, enum: ['efetuado', 'em_aberto'] },
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
    parameter name: :page, in: :query, type: :integer, description: 'Número da página'
    parameter name: :per_page, in: :query, type: :integer, description: 'Número de itens por página'
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
                   status: { type: :string,  enum: ['recebido', 'em_preparacao', 'pronto', 'finalizado'] },
                   observacao: { type: :string },
                   data: { type: :string, format: 'date' },
                   data_status: { type: :string, format: 'date' },
                   pagamento: { type: :string, enum: ['efetuado', 'em_aberto'] },
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

  path '/pedidos/em-preparacao' do
    get 'GET Pedidos em Preparação' do
      parameter name: :page, in: :query, type: :integer, description: 'Número da página'
      parameter name: :per_page, in: :query, type: :integer, description: 'Número de itens por página'
      tags 'Pedidos'
      produces 'application/json'

      response '200', 'pedidos found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   valor: { type: :number },
                   status: { type: :string,  enum: ['recebido', 'em_preparacao', 'pronto', 'finalizado'] },
                   observacao: { type: :string },
                   data: { type: :string, format: 'date' },
                   data_status: { type: :string, format: 'date' },
                   pagamento: { type: :string, enum: ['efetuado', 'em_aberto'] },
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
      parameter name: :page, in: :query, type: :integer, description: 'Número da página'
      parameter name: :per_page, in: :query, type: :integer, description: 'Número de itens por página'
      tags 'Pedidos'
      produces 'application/json'

      response '200', 'pedidos found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   valor: { type: :number },
                   status: { type: :string,  enum: ['recebido', 'em_preparacao', 'pronto', 'finalizado'] },
                   observacao: { type: :string },
                   data: { type: :string, format: 'date' },
                   data_status: { type: :string, format: 'date' },
                   pagamento: { type: :string, enum: ['efetuado', 'em_aberto'] },
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

  path '/pedidos/pago' do
    parameter name: :page, in: :query, type: :integer, description: 'Número da página'
    parameter name: :per_page, in: :query, type: :integer, description: 'Número de itens por página'
    get 'GET Pedidos Pagos' do
      tags 'Pedidos'
      produces 'application/json'

      response '200', 'pedidos found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   valor: { type: :number },
                   status: { type: :string,  enum: ['recebido', 'em_preparacao', 'pronto', 'finalizado'] },
                   observacao: { type: :string },
                   data: { type: :string, format: 'date' },
                   data_status: { type: :string, format: 'date' },
                   pagamento: { type: :string, enum: ['efetuado', 'em_aberto'] },
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

  path '/pedidos/em-aberto' do
    get 'GET Pedidos sem Pagamento confirmado' do
      parameter name: :page, in: :query, type: :integer, description: 'Número da página'
      parameter name: :per_page, in: :query, type: :integer, description: 'Número de itens por página'
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
                   pagamento: { type: :string, enum: ['em_aberto'] },
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
