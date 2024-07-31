class AddPagamentoToPedidos < ActiveRecord::Migration[7.1]
  def change
    add_column :pedidos, :pagamento, :string, default: 'em_aberto', null: false
  end
end