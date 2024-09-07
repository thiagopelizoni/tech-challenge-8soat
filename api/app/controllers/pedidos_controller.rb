class PedidosController < ApplicationController
  before_action :set_pedido, only: %i[ show update destroy pagar preparar receber pronto finalizar ]

  # GET /pedidos
  def index
    @pedidos = Pedido.page(params[:page]).per(params[:per_page]).order(updated_at: :desc)
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

    if params[:pagamento].present?
      pedidos = pedidos.where(pagamento: params[:pagamento])
    end

    render json: pedidos, each_serializer: PedidoSerializer
  end

  # GET /pedidos/pagamento-confirmado
  def pagamento_confirmado
    params[:pagamento] = 'confirmado'
    search
  end

  # GET /pedidos/pagamento-em-aberto
  def pagamento_em_aberto
    params[:pagamento] = 'em_aberto'
    search
  end

  # GET /pedidos/pagamento-recusado
  def pagamento_recusado
    params[:pagamento] = 'recusado'
    search
  end

  # GET /pedidos/pronto
  def prontos
    params[:status] = 'pronto'
    search
  end

  # GET /pedidos/recebido
  def recebido
    params[:status] = 'recebido'
    search
  end

  # GET /pedidos/em-preparacao
  def em_preparacao
    params[:status] = 'em_preparacao'
    search
  end

  # GET /pedidos/finalizado
  def finalizado
    params[:status] = 'finalizado'
    search
  end

  # PUT /pedidos/:id/pagar
  def pagar
    if @pedido.update(pagamento: 'confirmado', status: 'recebido')
      render json: @pedido, status: :ok
    else
      render json: @pedido.errors, status: :unprocessable_entity
    end
  end

  # PUT /pedidos/:id/receber
  def receber
    if @pedido.update(status: 'recebido')
      render json: @pedido, status: :ok
    else
      render json: @pedido.errors, status: :unprocessable_entity
    end
  end

  # PUT /pedidos/:id/preparar
  def preparar
    if @pedido.update(status: 'em_preparacao')
      render json: @pedido, status: :ok
    else
      render json: @pedido.errors, status: :unprocessable_entity
    end
  end

  # PUT /pedidos/:id/pronto
  def pronto
    if @pedido.update(status: 'pronto')
      render json: @pedido, status: :ok
    else
      render json: @pedido.errors, status: :unprocessable_entity
    end
  end

  # PUT /pedidos/:id/finalizar
  def finalizar
    if @pedido.update(status: 'finalizado')
      render json: @pedido, status: :ok
    else
      render json: @pedido.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pedido_params
      params.require(:pedido).permit(:valor, :status, :observacao, :pagamento, :cliente_id, produtos: [])
    end
end
