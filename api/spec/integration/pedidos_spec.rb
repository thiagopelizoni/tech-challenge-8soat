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

    post 'Criação de Pedido' do
      tags 'Pedidos'
      consumes 'application/json'
      parameter name: :pedido, in: :body, schema: {
        type: :object,
        properties: {
          cliente_id: { type: :integer, nullable: true },
          produtos: { type: :array, items: { type: :integer } },
          observacao: { type: :string, nullable: true },
          pagamento: { type: :string, enum: ['efetuado', 'em_aberto'] },
          status: { type: :string, enum: ['recebido', 'em_preparacao', 'pronto', 'finalizado'] }
        },
        required: ['produtos']
      }
  
      response '201', 'pedido criado' do
        let(:pedido) { { produtos: [1, 2], observacao: 'Sem cebola', pagamento: 'em_aberto', status: 'recebido' } }
        run_test!
      end
  
      response '422', 'parâmetros inválidos' do
        let(:pedido) { { produtos: [], observacao: 'Observacao muito longa' * 100, pagamento: 'efetuado', status: 'invalido' } }
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

    put 'Atualização de Pedido' do
      tags 'Pedidos'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :pedido, in: :body, schema: {
        type: :object,
        properties: {
          cliente_id: { type: :integer, nullable: true },
          produtos: { type: :array, items: { type: :integer } },
          observacao: { type: :string, nullable: true },
          pagamento: { type: :string, enum: ['efetuado', 'em_aberto'] },
          status: { type: :string, enum: ['recebido', 'em_preparacao', 'pronto', 'finalizado'] }
        },
        required: ['produtos']
      }
  
      response '200', 'pedido atualizado' do
        let(:id) { Pedido.create(produtos: [1, 2], observacao: 'Sem cebola', pagamento: 'em_aberto', status: 'recebido').id }
        let(:pedido) { { produtos: [3, 4], observacao: 'Com molho', pagamento: 'efetuado', status: 'pronto' } }
        run_test!
      end
  
      response '422', 'parâmetros inválidos' do
        let(:id) { Pedido.create(produtos: [1, 2], observacao: 'Sem cebola', pagamento: 'em_aberto', status: 'recebido').id }
        let(:pedido) { { produtos: [], observacao: 'Observacao muito longa' * 100, pagamento: 'efetuado', status: 'invalido' } }
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

  path '/pedidos/{id}/pagar' do
    put 'Atualiza o pagamento do pedido para "Efetuado"' do
      tags 'Pedidos'
      parameter name: :id, in: :path, type: :integer

      response '200', 'pagamento efetuado' do
        let(:pedido) { create(:pedido, pagamento: 'em_aberto') }
        let(:id) { pedido.id }
        run_test!
      end

      response '422', 'parâmetros inválidos' do
        let(:id) { 'invalid' }
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

  path '/pedidos/{id}/receber' do
    put 'Atualiza o status do pedido para "Recebido"' do
      tags 'Pedidos'
      parameter name: :id, in: :path, type: :integer

      response '200', 'pedido recebido' do
        let(:pedido) { create(:pedido, status: 'em_preparacao') }
        let(:id) { pedido.id }
        run_test!
      end

      response '422', 'parâmetros inválidos' do
        let(:id) { 'invalid' }
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

  path '/pedidos/{id}/preparar' do
    put 'Atualiza o status do pedido para "Em Preparação"' do
      tags 'Pedidos'
      parameter name: :id, in: :path, type: :integer

      response '200', 'pedido em preparação' do
        let(:pedido) { create(:pedido, status: 'recebido') }
        let(:id) { pedido.id }
        run_test!
      end

      response '422', 'parâmetros inválidos' do
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

  path '/pedidos/{id}/pronto' do
    put 'Atualiza o status do pedido para "Pronto"' do
      tags 'Pedidos'
      parameter name: :id, in: :path, type: :integer

      response '200', 'pedido pronto' do
        let(:pedido) { create(:pedido, status: 'em_preparacao') }
        let(:id) { pedido.id }
        run_test!
      end

      response '422', 'parâmetros inválidos' do
        let(:id) { 'invalid' }
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

  path '/pedidos/{id}/finalizar' do
    put 'Atualiza o status do pedido para "Finalizado"' do
      tags 'Pedidos'
      parameter name: :id, in: :path, type: :integer

      response '200', 'pedido finalizado' do
        let(:pedido) { create(:pedido, status: 'pronto') }
        let(:id) { pedido.id }
        run_test!
      end

      response '422', 'parâmetros inválidos' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

end
