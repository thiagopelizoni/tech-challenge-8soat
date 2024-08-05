require 'swagger_helper'

RSpec.describe 'clientes API', type: :request do
  path '/clientes' do
    get 'Listar Clientes' do
      tags 'Clientes'
      produces 'application/json'
      
      response '200', 'clientes encontrados' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   nome: { type: :string },
                   data_nascimento: { type: :string, format: :date },
                   cpf: { type: :string },
                   email: { type: :string },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: ['id', 'nome', 'data_nascimento', 'cpf', 'email']
               }
  
        let!(:clientes) { create_list(:cliente, 5) }
        run_test!
      end
    end
  end  

  path '/clientes/{id}' do
    get 'Exibe um cliente' do
      tags 'Clientes'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'cliente encontrado' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 nome: { type: :string },
                 data_nascimento: { type: :string, format: :date },
                 cpf: { type: :string },
                 email: { type: :string },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: ['id', 'nome', 'data_nascimento', 'cpf', 'email']

        let(:id) { Cliente.create(nome: 'Nome do Cliente', data_nascimento: '2000-01-01', cpf: '12345678901', email: 'cliente@example.com', senha: 'password').id }
        run_test!
      end

      response '404', 'cliente não encontrado' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    path '/clientes/cpf/{cpf}' do
      get 'Busca cliente por CPF' do
        tags 'Clientes'
        consumes 'application/json'
        parameter name: :cpf, in: :path, type: :string, description: 'CPF do cliente'
  
        response(200, 'successful') do
          let(:cpf) { create(:cliente).cpf }
          schema '$ref' => '#/components/schemas/Cliente'
          run_test!
        end
  
        response(404, 'not found') do
          let(:cpf) { '11111111111' }
          run_test!
        end
  
        response(400, 'bad request') do
          let(:cpf) { 'cpf_invalido' }
          run_test!
        end
      end
    end

    put 'Atualiza um cliente' do
      tags 'Clientes'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :cliente, in: :body, schema: {
        type: :object,
        properties: {
          nome: { type: :string },
          data_nascimento: { type: :string, format: :date },
          cpf: { type: :string },
          email: { type: :string },
          senha: { type: :string }
        },
        required: ['nome', 'data_nascimento', 'cpf', 'email', 'senha']
      }

      response '200', 'cliente atualizado' do
        let(:id) { Cliente.create(nome: 'Nome do Cliente', data_nascimento: '2000-01-01', cpf: '12345678901', email: 'cliente@example.com', senha: 'password').id }
        let(:cliente) { { nome: 'Nome Atualizado', data_nascimento: '2000-01-01', cpf: '12345678901', email: 'clienteatualizado@example.com', senha: 'newpassword' } }
        run_test!
      end

      response '422', 'parâmetros inválidos' do
        let(:id) { Cliente.create(nome: 'Nome do Cliente', data_nascimento: '2000-01-01', cpf: '12345678901', email: 'cliente@example.com', senha: 'password').id }
        let(:cliente) { { nome: 'Nome', data_nascimento: '2000-01-01', cpf: '12345678901', email: 'cliente@example.com', senha: '123' } }
        run_test!
      end
    end

    path '/clientes' do
      post 'Cria um cliente' do
        tags 'Clientes'
        consumes 'application/json'
        parameter name: :cliente, in: :body, schema: {
          type: :object,
          properties: {
            nome: { type: :string },
            data_nascimento: { type: :string, format: :date },
            cpf: { type: :string },
            email: { type: :string },
            senha: { type: :string }
          },
          required: ['nome', 'data_nascimento', 'cpf', 'email', 'senha']
        }
  
        response '201', 'cliente criado' do
          let(:cliente) { { nome: 'Nome do Cliente', data_nascimento: '2000-01-01', cpf: '12345678901', email: 'cliente@example.com', senha: 'password' } }
          run_test!
        end
  
        response '422', 'parâmetros inválidos' do
          let(:cliente) { { nome: 'Nome', data_nascimento: '2000-01-01', cpf: '12345678901', email: 'cliente@example.com', senha: '123' } }
          run_test!
        end
      end
    end

  end
end
