class AddUniqueIndexToCategoriasNome < ActiveRecord::Migration[7.1]
  def change
    add_index :categorias, :nome, unique: true
  end
end
