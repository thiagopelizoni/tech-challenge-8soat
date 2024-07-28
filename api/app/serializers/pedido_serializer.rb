class PedidoSerializer < ActiveModel::Serializer
  attributes :id, :valor, :status, :observacao
  belongs_to :cliente, serializer: ClienteSerializer
  has_many :produtos, serializer: ProdutoSerializer

  def produtos
    object.produtos.map { |produto_id| Produto.find(produto_id) }
  end
end
