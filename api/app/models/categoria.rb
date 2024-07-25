class Categoria < ApplicationRecord
  validates :nome, presence: true, uniqueness: true
end
