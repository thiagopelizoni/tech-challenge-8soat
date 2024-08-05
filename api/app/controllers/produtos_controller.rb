class ProdutosController < ApplicationController
  before_action :set_produto, only: %i[ show update destroy ]

  # GET /produtos
  def index
    @produtos = Produto.page(params[:page]).per(params[:per_page])
    render json: @produtos
  end

  # GET /produtos/ativos
  def ativos
    @produtos = Produto.ativos.page(params[:page]).per(params[:per_page])
    render json: @produtos
  end

  # GET /produtos/inativos
  def inativos
    @produtos = Produto.inativos.page(params[:page]).per(params[:per_page])
    render json: @produtos
  end

  # GET /produtos/1
  def show
    render json: @produto
  end

  def search_by_nome
    @produtos = Produto.where("nome ILIKE ?", "%#{params[:nome]}%")
    if @produtos.exists?
      render json: @produtos
    else
      render json: { message: "Nenhum produto encontrado com o nome: #{params[:nome]}" }, status: :not_found
    end
  end

  # POST /produtos
  def create
    @produto = Produto.new(produto_params)

    if @produto.save
      render json: @produto, status: :created, location: @produto
    else
      render json: @produto.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /produtos/1
  def update
    if @produto.update(produto_params)
      render json: @produto
    else
      render json: @produto.errors, status: :unprocessable_entity
    end
  end

  # DELETE /produtos/1
  def destroy
    @produto.update(status: :inativo)
    render json: { message: 'Produto inativodo com sucesso' }
  end

  private

  def set_produto
    @produto = Produto.find(params[:id])
  end

  def produto_params
    params.require(:produto).permit(:nome, :descricao, :preco, :categoria_id, :status)
  end
end
