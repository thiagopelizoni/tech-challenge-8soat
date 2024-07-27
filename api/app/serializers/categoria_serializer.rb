class CategoriaSerializer < ActiveModel::Serializer
  attributes :id, :nome, :descricao
  has_many :produtos
end