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

  def search_by_nome
    @clientes = Cliente.where("nome ILIKE ?", "%#{params[:nome]}%")
    render_search_results(@clientes, params[:nome])
  end

  def search_by_email
    @clientes = Cliente.where("email ILIKE ?", "%#{params[:email]}%")
    render_search_results(@clientes, params[:email])
  end

  def search_by_cpf
    @clientes = Cliente.where("cpf ILIKE ?", "%#{params[:cpf]}%")
    render_search_results(@clientes, params[:cpf])
  end

  def search_by_data_nascimento
    @clientes = Cliente.where("data_nascimento = ?", params[:data_nascimento])
    render_search_results(@clientes, params[:data_nascimento])
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

  def render_search_results(clientes, query_param)
    if clientes.exists?
      render json: clientes
    else
      render json: { message: "Nenhum cliente encontrado com o parâmetro fornecido: #{query_param}" }, status: :not_found
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cliente_params
    params.require(:cliente).permit(:nome, :data_nascimento, :cpf, :email, :senha)
  end
end
