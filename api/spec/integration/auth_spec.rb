require 'swagger_helper'
require 'bcrypt'

RSpec.describe 'Auth API', type: :request do
  path '/login' do
    post('Login do cliente') do
      tags 'Autenticação'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          cpf: { type: :string, example: '12345678901' },
          senha: { type: :string, example: '@TechChallenge!' }
        },
        required: %w[cpf senha]
      }

      response '200', 'Login bem-sucedido' do
        let(:cliente) { create(:cliente, cpf: '12345678901', senha: '123456') }
        let(:payload) { { cpf: cliente.cpf, senha: '@TechChallenge!' } }

        before do
          allow(Net::HTTP).to receive(:post_form).and_return(OpenStruct.new(
            code: '200',
            body: { success: true }.to_json
          ))
        end

        schema type: :object,
               properties: {
                 id: { type: :integer, example: 1 },
                 nome: { type: :string, example: 'João Silva' },
                 email: { type: :string, example: 'joao.silva@example.com' },
                 cpf: { type: :string, example: '12345678901' }
               }

        run_test!
      end

      response '401', 'Credenciais inválidas' do
        let(:payload) { { cpf: '12345678901', senha: 'senha_incorreta' } }

        before do
          allow(Net::HTTP).to receive(:post_form).and_return(OpenStruct.new(
            code: '401',
            body: { success: false }.to_json
          ))
        end

        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Credenciais inválidas.' }
               }

        run_test!
      end

      response '422', 'Parâmetros ausentes' do
        let(:payload) { { cpf: '', senha: '' } }
        schema type: :object,
               properties: {
                 message: { type: :string, example: 'CPF e senha são obrigatórios.' }
               }

        run_test!
      end

      response '502', 'Erro no serviço de autenticação' do
        let(:payload) { { cpf: '12345678901', senha: '123456' } }

        before do
          allow(Net::HTTP).to receive(:post_form).and_return(OpenStruct.new(
            code: '502',
            body: { message: 'Erro ao comunicar com o serviço de autenticação.' }.to_json
          ))
        end

        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Erro ao comunicar com o serviço de autenticação.' }
               }

        run_test!
      end
    end
  end
end
