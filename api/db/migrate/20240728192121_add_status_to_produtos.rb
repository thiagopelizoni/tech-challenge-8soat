class AddStatusToProdutos < ActiveRecord::Migration[7.1]
  def change
    add_column :produtos, :status, :string, default: 'ativo'
  end
end
