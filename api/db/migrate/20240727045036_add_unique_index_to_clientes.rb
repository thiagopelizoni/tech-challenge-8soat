class AddUniqueIndexToClientes < ActiveRecord::Migration[7.1]
  def change
    add_index :clientes, :cpf, unique: true
    add_index :clientes, :email, unique: true
  end
end
