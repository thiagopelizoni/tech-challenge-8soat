class Pedido < ApplicationRecord
  belongs_to :cliente, optional: true

  before_save :calculate_valor

  enum status: { recebido: 'recebido', em_preparacao: 'em_preparacao', pronto: 'pronto', finalizado: 'finalizado' }

  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :produtos, presence: true
  validates :observacao, length: { maximum: 500 }

  private

  def calculate_valor
    self.valor = produtos.sum { |produto_id| Produto.find(produto_id).preco }
  end
end