class Produto < ApplicationRecord
  belongs_to :categoria

  validates :nome, presence: true
  validates :preco, presence: true, numericality: { greater_than_or_equal_to: 0 }
end