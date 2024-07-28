class ChangeClienteIdOnPedidos < ActiveRecord::Migration[7.1]
  def change
    change_column_null :pedidos, :cliente_id, true
  end
end
