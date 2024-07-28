class ProdutoSerializer < ActiveModel::Serializer
  attributes :id, :nome, :descricao, :preco, :status
  has_one :categoria
end