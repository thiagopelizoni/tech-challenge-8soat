class CategoriaSerializer < ActiveModel::Serializer
  attributes :id, :nome
  has_many :produtos
end