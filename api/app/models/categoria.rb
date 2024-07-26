class Categoria < ApplicationRecord
  has_many :produtos, dependent: :destroy

  validates :nome, presence: true, uniqueness: true
end
