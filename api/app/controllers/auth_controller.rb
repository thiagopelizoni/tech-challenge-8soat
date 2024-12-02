class AuthController < ApplicationController
    require 'net/http'
    require 'uri'
  
    def login
      cpf = params[:cpf]
      senha = params[:senha]
  
      if cpf.blank? || senha.blank?
        render json: { message: "CPF e senha são obrigatórios." }, status: :unprocessable_entity
        return
      end
  
      uri = URI(ENV['API_GATEWAY_URL'])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
  
      request = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })
      request.body = { cpf: cpf, senha: senha }.to_json
  
      begin
        response = http.request(request)
        if response.code.to_i == 200
          body = JSON.parse(response.body)
          if body['success']
            cliente = Cliente.find_by(cpf: cpf)
            if cliente
              render json: cliente, serializer: ClienteSerializer, status: :ok
            else
              render json: { message: "Cliente não encontrado no sistema." }, status: :not_found
            end
          else
            render json: { message: "Credenciais inválidas." }, status: :unauthorized
          end
        else
          render json: { message: "Erro ao comunicar com o serviço de autenticação." }, status: :bad_gateway
        end
      rescue JSON::ParserError
        render json: { message: "Resposta inválida do serviço de autenticação." }, status: :bad_gateway
      rescue => e
        render json: { message: "Erro inesperado: #{e.message}" }, status: :internal_server_error
      end
    end
  end
  