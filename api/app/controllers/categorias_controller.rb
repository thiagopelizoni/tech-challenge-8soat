class CategoriasController < ApplicationController
  before_action :set_categoria, only: %i[ show update destroy ]

  # GET /categorias
  def index
    @categorias = Categoria.page(params[:page]).per(params[:per_page])

    render json: @categorias
  end

  # GET /categorias/1
  def show
    render json: @categoria
  end

  def search
    query_params = params.slice(:nome, :descricao)
    @categorias = Categoria.where(nil)
    
    query_params.each do |key, value|
      @categorias = @categorias.where("#{key} ILIKE ?", "%#{value}%").page(params[:page]).per(params[:per_page])
    end

    if @categorias.exists?
      render json: @categorias
    else
      render json: { message: "Nenhuma categoria encontrado com os parâmetros fornecidos: #{query_params.to_unsafe_h}" }, status: :not_found
    end
  end

  # POST /categorias
  def create
    @categoria = Categoria.new(categoria_params)

    if @categoria.save
      render json: @categoria, status: :created, location: @categoria
    else
      render json: @categoria.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categorias/1
  def update
    if @categoria.update(categoria_params)
      render json: @categoria
    else
      render json: @categoria.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categorias/1
  def destroy
    render json: { message: 'Não é permitido excluir uma categoria!' }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categoria
      @categoria = Categoria.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def categoria_params
      params.require(:categoria).permit(:nome, :descricao)
    end
end
