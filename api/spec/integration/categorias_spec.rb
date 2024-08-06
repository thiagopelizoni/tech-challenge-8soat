require 'swagger_helper'

RSpec.describe 'Categorias API', type: :request do
  path '/categorias' do
    get 'Listar Categorias' do
      parameter name: :page, in: :query, type: :integer, description: 'Número da página'
      parameter name: :per_page, in: :query, type: :integer, description: 'Número de itens por página'
      tags 'Categorias'
      produces 'application/json'
      
      response '200', 'categorias encontradas' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/categoria' }
        run_test!
      end
    end

    post 'Criar Categoria' do
      tags 'Categorias'
      consumes 'application/json'
      parameter name: :categoria, in: :body, schema: {
        type: :object,
        properties: {
          nome: { type: :string },
          descricao: { type: :string }
        },
        required: ['nome']
      }

      response '201', 'categoria criada' do
        schema '$ref' => '#/components/schemas/categoria'

        let(:categoria) { { nome: 'Lanches', descricao: 'Lanches variados' } }
        run_test!
      end

      response '422', 'categoria não criada' do
        schema type: :object,
               properties: {
                 errors: {
                   type: :object,
                   additionalProperties: { type: :array, items: { type: :string } }
                 }
               }

        let(:categoria) { { nome: '' } }
        run_test!
      end
    end
  end

  path '/categorias/{id}' do
    get 'Exibir uma Categoria' do
      tags 'Categorias'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'categoria encontrada' do
        schema '$ref' => '#/components/schemas/categoria'

        let(:id) { Categoria.create!(nome: 'Lanches', descricao: 'Lanches variados').id }
        run_test!
      end

      response '404', 'categoria não encontrada' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Atualizar uma Categoria' do
      tags 'Categorias'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :categoria, in: :body, schema: {
        type: :object,
        properties: {
          nome: { type: :string },
          descricao: { type: :string }
        },
        required: ['nome']
      }

      response '200', 'categoria atualizada' do
        schema '$ref' => '#/components/schemas/categoria'

        let(:id) { Categoria.create!(nome: 'Lanches', descricao: 'Lanches variados').id }
        let(:categoria) { { nome: 'Lanches Atualizados', descricao: 'Lanches diversos' } }
        run_test!
      end

      response '404', 'categoria não encontrada' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '422', 'categoria não atualizada' do
        schema type: :object,
               properties: {
                 errors: {
                   type: :object,
                   additionalProperties: { type: :array, items: { type: :string } }
                 }
               }

        let(:id) { Categoria.create!(nome: 'Lanches', descricao: 'Lanches variados').id }
        let(:categoria) { { nome: '' } }
        run_test!
      end
    end

  end
end
