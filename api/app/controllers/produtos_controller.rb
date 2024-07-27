class ProdutosController < ApplicationController
  before_action :set_produto, only: %i[ show update destroy ]

  # GET /produtos
  def index
    @produtos = Produto.all

    render json: @produtos
  end

  # GET /produtos/1
  def show
    render json: @produto
  end

  # GET /produtos/search?nome=hamburguer
  # GET /produtos/search?preco=10
  def search
    query_params = params.slice(:nome, :preco, :categoria_id)
    @produtos = Produto.where(nil)

    query_params.each do |key, value|
      if key == "preco"
        @produtos = @produtos.where("#{key} = ?", value)
      else
        @produtos = @produtos.where("#{key} ILIKE ?", "%#{value}%")
      end
    end

    if @produtos.exists?
      render json: @produtos
    else
      render json: { message: "Nenhum produto encontrado com os parâmetros fornecidos: #{query_params.to_unsafe_h}" }, status: :not_found
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
    @produto.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produto
      @produto = Produto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def produto_params
      params.require(:produto).permit(:nome, :descricao, :preco, :categoria_id)
    end
end
