class Pedido < ApplicationRecord
  belongs_to :cliente, optional: true

  before_save :calculate_valor
  before_create :set_pagamento_em_aberto

  enum pagamento: { efetuado: 'efetuado', em_aberto: 'em_aberto' }
  enum status: { recebido: 'recebido', em_preparacao: 'em_preparacao', pronto: 'pronto', finalizado: 'finalizado' }

  validates :status, inclusion: { in: statuses.keys }, if: -> { pagamento == 'efetuado' }
  validates :produtos, presence: true
  validates :observacao, length: { maximum: 500 }
  validate :status_presence_based_on_pagamento

  before_update :validate_status_change

  default_scope { order(updated_at: :desc) }

  private

  def calculate_valor
    self.valor = produtos.sum { |produto_id| Produto.find(produto_id).preco }
  end

  def set_pagamento_em_aberto
    self.pagamento = 'em_aberto'
  end

  def validate_status_change
    if status_changed? && pagamento != 'efetuado'
      errors.add(:status, 'Status não pode ser alterado a menos que o Pagamento esteja como Efetuado')
      throw :abort
    end
  end

  def status_presence_based_on_pagamento
    if pagamento == 'em_aberto' && status.present?
      errors.add(:status, 'Não se pode atribuir Status se o Pagamento estiver Em Aberto')
    end

    if pagamento == 'efetuado' && status.blank?
      errors.add(:status, 'Status é obrigatório quando o Pagamento já tiver sido Efetuado')
    end
  end
end
