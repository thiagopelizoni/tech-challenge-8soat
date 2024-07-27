class PedidoSerializer < ActiveModel::Serializer
  attributes :id, :produtos, :valor, :status, :observacao
  has_one :cliente
end
