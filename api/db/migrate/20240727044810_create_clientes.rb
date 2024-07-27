class CreateClientes < ActiveRecord::Migration[7.1]
  def change
    create_table :clientes do |t|
      t.string :nome
      t.date :data_nascimento
      t.string :cpf
      t.string :email
      t.string :senha

      t.timestamps
    end
  end
end
