class ProdutoSerializer < ActiveModel::Serializer
  attributes :id, :nome, :descricao, :preco
  has_one :categoria
end