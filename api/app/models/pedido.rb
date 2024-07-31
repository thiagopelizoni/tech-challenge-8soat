class Pedido < ApplicationRecord
  belongs_to :cliente, optional: true

  before_save :calculate_valor
  before_create :set_pagamento_em_aberto

  enum pagamento: { efetuado: 'efetuado', em_aberto: 'em_aberto' }
  enum status: { recebido: 'recebido', em_preparacao: 'em_preparacao', pronto: 'pronto', finalizado: 'finalizado' }

  validates :status, inclusion: { in: statuses.keys }, if: -> { pagamento == 'efetuado' }
  validates :produtos, presence: true
  validates :observacao, length: { maximum: 500 }

  before_update :validate_status_change

  private

  def calculate_valor
    self.valor = produtos.sum { |produto_id| Produto.find(produto_id).preco }
  end

  def set_pagamento_em_aberto
    self.pagamento = 'em_aberto'
  end

  def validate_status_change
    if status_changed? && pagamento != 'efetuado'
      errors.add(:status, 'não pode ser atualizado a menos que o pagamento seja efetuado')
      throw :abort
    end
  end
end
