class PedidosController < ApplicationController
  before_action :set_pedido, only: %i[ show update destroy ]

  # GET /pedidos
  def index
    @pedidos = Pedido.all

    render json: @pedidos
  end

  # GET /pedidos/1
  def show
    render json: @pedido
  end  

  # POST /pedidos
  def create
    @pedido = Pedido.new(pedido_params)

    if @pedido.save
      render json: @pedido, status: :created, location: @pedido
    else
      render json: @pedido.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pedidos/1
  def update
    if @pedido.update(pedido_params)
      render json: @pedido
    else
      render json: @pedido.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pedidos/1
  def destroy
    @pedido.update(status: :finalizado)
    redirect_to pedidos_url, notice: 'Pedido foi finalizado com sucesso.'
  end

  # GET /pedidos/search?attribute=value
  # GET /pedidos/search?status=em_preparacao
  # GET /pedidos/search?status=recebido
  # GET /pedidos/search?status=pronto
  # GET /pedidos/search?status=finalizado
  # GET /pedidos/search?cliente_nulo=true
  # GET /pedidos/search?cpf=12345678901
  # GET /pedidos/search?cpf=23456789012&status=em_preparacao
  # GET /pedidos/search?email=platao@example.com
  # GET /pedidos/search?produto=taco
  def search
    pedidos = Pedido.all

    if params[:email].present?
      cliente = Cliente.find_by(email: params[:email])
      pedidos = pedidos.where(cliente: cliente) if cliente
    end

    if params[:cpf].present?
      cliente = Cliente.find_by(cpf: params[:cpf])
      pedidos = pedidos.where(cliente: cliente) if cliente
    end

    if params[:produto].present?
      produto_ids  = Produto.where("nome ILIKE ?", "%#{params[:produto]}%").pluck(:id)
      pedidos = pedidos.select { |pedido| (pedido.produtos & produto_ids).any? }
    end

    pedidos = pedidos.where(cliente: nil) if params[:cliente_nulo].present? && params[:cliente_nulo] == 'true'

    if params[:status].present?
      pedidos = pedidos.where(status: params[:status])
    end

    render json: pedidos, each_serializer: PedidoSerializer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pedido_params
      params.require(:pedido).permit(:cliente_id, :produtos, :valor, :status, :observacao)
    end
end
