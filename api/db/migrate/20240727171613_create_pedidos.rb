class CreatePedidos < ActiveRecord::Migration[7.1]
  def change
    create_table :pedidos do |t|
      t.references :cliente, null: false, foreign_key: true
      t.json :produtos
      t.decimal :valor
      t.string :status
      t.text :observacao

      t.timestamps
    end
  end
end
