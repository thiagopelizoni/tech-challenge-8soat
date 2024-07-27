class Cliente < ApplicationRecord
  has_secure_password validations: false

  validates :nome, presence: true, length: { minimum: 6, maximum: 140 }
  validates :data_nascimento, presence: true, date: { before_or_equal_to: 16.years.ago, message: 'deve ser de no mínimo 16 anos de idade' }
  validates :cpf, presence: true, uniqueness: true, format: { with: /\A\d{11}\z/, message: "deve conter 11 dígitos" }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :senha, presence: true, length: { minimum: 6 }
  
  before_save :encrypt_password

  private

  def encrypt_password
    self.senha = BCrypt::Password.create(senha)
  end
end
