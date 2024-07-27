class ClienteSerializer < ActiveModel::Serializer
  attributes :id, :nome, :data_nascimento, :cpf, :email
end
