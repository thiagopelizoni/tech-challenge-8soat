class ClientesController < ApplicationController
  before_action :set_cliente, only: %i[ show update destroy ]

  # GET /clientes
  def index
    @clientes = Cliente.all

    render json: @clientes
  end

  # GET /clientes/1
  def show
    render json: @cliente
  end

  # GET /clientes/search?nome=Aristóteles
  # GET /clientes/search?email=platao@example.com
  # GET /clientes/search?cpf=12345678901
  # GET /clientes/search?data_nascimento=1980-01-01
  def search
    query_params = params.slice(:nome, :email, :cpf, :data_nascimento)
    @clientes = Cliente.where(nil)
    
    query_params.each do |key, value|
      @clientes = @clientes.where("#{key} ILIKE ?", "%#{value}%")
    end

    if @clientes.exists?
      render json: @clientes
    else
      render json: { message: "Nenhum cliente encontrado com os parâmetros fornecidos: #{query_params.to_unsafe_h}" }, status: :not_found
    end
  end

  # GET /clientes/cpf/:cpf
  def cpf
    cpf = params[:cpf]
  
    if cpf.present? && cpf.match?(/^\d{11}$/)
      @cliente = Cliente.find_by(cpf: cpf)
  
      if @cliente
        render json: @cliente
      else
        render json: { message: "Nenhum cliente encontrado com o CPF: #{cpf}" }, status: :not_found
      end
    else
      render json: { message: "CPF inválido ou não fornecido." }, status: :bad_request
    end
  end

  # POST /clientes
  def create
    @cliente = Cliente.new(cliente_params)

    if @cliente.save
      render json: @cliente, status: :created, location: @cliente
    else
      render json: @cliente.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clientes/1
  def update
    if @cliente.update(cliente_params)
      render json: @cliente
    else
      render json: @cliente.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clientes/1
  def destroy
    @cliente.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cliente_params
      params.require(:cliente).permit(:nome, :data_nascimento, :cpf, :email, :senha)
    end
end
