require 'swagger_helper'

RSpec.describe 'Clientes API', type: :request do
  path '/clientes' do
    get 'Listar Clientes' do
      tags 'Clientes'
      produces 'application/json'
      
      response '200', 'clientes encontrados' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/cliente' }

        let!(:clientes) { create_list(:cliente, 5) }
        run_test!
      end
    end

    post 'Cria um cliente' do
      tags 'Clientes'
      consumes 'application/json'
      parameter name: :cliente, in: :body, schema: { '$ref' => '#/components/schemas/cliente' }
  
      response '201', 'cliente criado' do
        let(:cliente) { { nome: 'Nome do Cliente', data_nascimento: '2000-01-01', cpf: '12345678901', email: 'cliente@example.com', senha: 'password' } }
        run_test!
      end
  
      response '422', 'parâmetros inválidos' do
        schema type: :object,
               properties: {
                 errors: {
                   type: :object,
                   additionalProperties: { type: :array, items: { type: :string } }
                 }
               }
        let(:cliente) { { nome: 'Nome', data_nascimento: '2000-01-01', cpf: '12345678901', email: 'cliente@example.com', senha: '123' } }
        run_test!
      end
    end
  end  

  path '/clientes/{id}' do
    get 'Busca um Cliente pelo seu ID' do
      tags 'Clientes'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'cliente encontrado' do
        schema '$ref' => '#/components/schemas/cliente'

        let(:id) { Cliente.create(nome: 'Nome do Cliente', data_nascimento: '2000-01-01', cpf: '12345678901', email: 'cliente@example.com', senha: 'password').id }
        run_test!
      end

      response '404', 'cliente não encontrado' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Atualiza um cliente' do
      tags 'Clientes'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :cliente, in: :body, schema: { '$ref' => '#/components/schemas/cliente' }

      response '200', 'cliente atualizado' do
        schema '$ref' => '#/components/schemas/cliente'

        let(:id) { Cliente.create(nome: 'Nome do Cliente', data_nascimento: '2000-01-01', cpf: '12345678901', email: 'cliente@example.com', senha: 'password').id }
        let(:cliente) { { nome: 'Nome Atualizado', data_nascimento: '2000-01-01', cpf: '12345678901', email: 'clienteatualizado@example.com', senha: 'newpassword' } }
        run_test!
      end

      response '422', 'parâmetros inválidos' do
        schema type: :object,
               properties: {
                 errors: {
                   type: :object,
                   additionalProperties: { type: :array, items: { type: :string } }
                 }
               }
        let(:id) { Cliente.create(nome: 'Nome do Cliente', data_nascimento: '2000-01-01', cpf: '12345678901', email: 'cliente@example.com', senha: 'password').id }
        let(:cliente) { { nome: 'Nome', data_nascimento: '2000-01-01', cpf: '12345678901', email: 'cliente@example.com', senha: '123' } }
        run_test!
      end
    end
  end

  path '/clientes/nome/{nome}' do
    get 'Busca clientes pelo Nome' do
      tags 'Clientes'
      produces 'application/json'
      parameter name: :nome, in: :path, type: :string, description: 'Nome do cliente'
  
      response '200', 'Clientes encontrados' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/cliente' }
  
        let(:nome) { 'Aristóteles' }
        run_test!
      end
  
      response '404', 'Nenhum cliente encontrado' do
        let(:nome) { 'NomeInexistente' }
        run_test!
      end
    end
  end

  path '/clientes/email/{email}' do
    get 'Busca clientes por email' do
      tags 'Clientes'
      produces 'application/json'
      parameter name: :email, in: :path, type: :string, description: 'Email do cliente'
  
      response '200', 'Clientes encontrados' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/cliente' }
  
        let(:email) { 'platao@example.com' }
        run_test!
      end
  
      response '404', 'Nenhum cliente encontrado' do
        let(:email) { 'emailinexistente@example.com' }
        run_test!
      end
    end
  end

  path '/clientes/cpf/{cpf}' do
    get 'Busca um cliente pelo CPF' do
      tags 'Clientes'
      produces 'application/json'
      parameter name: :cpf, in: :path, type: :string, description: 'CPF do cliente'
  
      response '200', 'Clientes encontrados' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/cliente' }
  
        let(:cpf) { '12345678901' }
        run_test!
      end
  
      response '404', 'Nenhum cliente encontrado' do
        let(:cpf) { '00000000000' }
        run_test!
      end
    end
  end

  path '/clientes/data_nascimento/{data_nascimento}' do
    get 'Busca clientes pela Data de Nascimento' do
      tags 'Clientes'
      produces 'application/json'
      parameter name: :data_nascimento, in: :path, type: :string, description: 'Data de nascimento do cliente (YYYY-MM-DD)'
  
      response '200', 'Clientes encontrados' do
        schema type: :array,
