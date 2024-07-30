# spec/integration/produtos_spec.rb
require 'swagger_helper'

RSpec.describe 'Produtos API', type: :request do
  path '/produtos' do
    get 'Listar todos os produtos' do
      parameter name: :page, in: :query, type: :integer, description: 'Número da página'
      parameter name: :per_page, in: :query, type: :integer, description: 'Número de itens por página'
      tags 'Produtos'
      produces 'application/json'
      
      response '200', 'produtos encontrados' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   nome: { type: :string },
                   descricao: { type: :string },
                   preco: { type: :number },
                   categoria_id: { type: :integer },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: ['id', 'nome', 'descricao', 'preco', 'categoria_id', 'created_at', 'updated_at']
               }
        run_test!
      end
    end

    post 'Criar um produto' do
      tags 'Produtos'
      consumes 'application/json'
      parameter name: :produto, in: :body, schema: {
        type: :object,
        properties: {
          nome: { type: :string },
          descricao: { type: :string },
          preco: { type: :number },
          categoria_id: { type: :integer }
        },
        required: ['nome', 'preco', 'categoria_id']
      }

      response '201', 'produto criado' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 nome: { type: :string },
                 descricao: { type: :string },
                 preco: { type: :number },
                 categoria_id: { type: :integer },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: ['id', 'nome', 'descricao', 'preco', 'categoria_id', 'created_at', 'updated_at']

        let(:produto) { { nome: 'Hamburguer', descricao: 'Hamburguer de carne com queijo', preco: 15.0, categoria_id: 1 } }
        run_test!
      end

      response '422', 'produto não criado' do
        schema type: :object,
               properties: {
                 errors: {
                   type: :object,
                   additionalProperties: { type: :array, items: { type: :string } }
                 }
               }

        let(:produto) { { nome: '' } }
        run_test!
      end
    end
  end

  path '/produtos/{id}' do
    get 'Mostrar um produto' do
      tags 'Produtos'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'produto encontrado' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 nome: { type: :string },
                 descricao: { type: :string },
                 preco: { type: :number },
                 categoria_id: { type: :integer },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: ['id', 'nome', 'descricao', 'preco', 'categoria_id', 'created_at', 'updated_at']

        let(:id) { Produto.create!(nome: 'Hamburguer', descricao: 'Hamburguer de carne com queijo', preco: 15.0, categoria_id: 1).id }
        run_test!
      end

      response '404', 'produto não encontrado' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Atualizar um produto' do
      tags 'Produtos'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :produto, in: :body, schema: {
        type: :object,
        properties: {
          nome: { type: :string },
          descricao: { type: :string },
          preco: { type: :number },
          categoria_id: { type: :integer }
        },
        required: ['nome', 'preco', 'categoria_id']
      }

      response '200', 'produto atualizado' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 nome: { type: :string },
                 descricao: { type: :string },
                 preco: { type: :number },
                 categoria_id: { type: :integer },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: ['id', 'nome', 'descricao', 'preco', 'categoria_id', 'created_at', 'updated_at']

        let(:id) { Produto.create!(nome: 'Hamburguer', descricao: 'Hamburguer de carne com queijo', preco: 15.0, categoria_id: 1).id }
        let(:produto) { { nome: 'Hamburguer Atualizado', descricao: 'Hamburguer de carne com queijo e bacon', preco: 20.0, categoria_id: 1 } }
        run_test!
      end

      response '404', 'produto não encontrado' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '422', 'produto não atualizado' do
        schema type: :object,
               properties: {
                 errors: {
                   type: :object,
                   additionalProperties: { type: :array, items: { type: :string } }
                 }
               }

        let(:id) { Produto.create!(nome: 'Hamburguer', descricao: 'Hamburguer de carne com queijo', preco: 15.0, categoria_id: 1).id }
        let(:produto) { { nome: '' } }
        run_test!
      end
    end

    delete 'Deletar um produto' do
      tags 'Produtos'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '204', 'produto deletado' do
        let(:id) { Produto.create!(nome: 'Hamburguer', descricao: 'Hamburguer de carne com queijo', preco: 15.0, categoria_id: 1).id }
        run_test!
      end

      response '404', 'produto não encontrado' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
