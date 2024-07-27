# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Categoria.create([
  { nome: 'Lanches' },
  { nome: 'Acompanhamentos' },
  { nome: 'Bebidas' },
  { nome: 'Sobremesas' }
])

Categoria.find_by(nome: 'Lanches').produtos.create([
  { nome: 'Hamburguer', descricao: 'Hamburguer de carne com queijo', preco: 15.0 },
  { nome: 'Sanduíche Natural', descricao: 'Sanduíche de frango com alface', preco: 12.0 },
  { nome: 'Cachorro Quente', descricao: 'Cachorro quente com molho especial', preco: 10.0 },
  { nome: 'Taco', descricao: 'Taco mexicano com carne moída', preco: 18.0 },
  { nome: 'Wrap', descricao: 'Wrap de frango com legumes', preco: 14.0 }
])

Categoria.find_by(nome: 'Acompanhamentos').produtos.create([
  { nome: 'Batata Frita', descricao: 'Batata frita crocante', preco: 8.0 },
  { nome: 'Onion Rings', descricao: 'Anéis de cebola empanados', preco: 9.0 },
  { nome: 'Salada Caesar', descricao: 'Salada Caesar com frango', preco: 12.0 },
  { nome: 'Mozzarella Sticks', descricao: 'Palitos de queijo empanados', preco: 11.0 },
  { nome: 'Sopa do Dia', descricao: 'Sopa do dia', preco: 7.0 }
])

Categoria.find_by(nome: 'Bebidas').produtos.create([
  { nome: 'Refrigerante', descricao: 'Refrigerante gelado', preco: 5.0 },
  { nome: 'Suco Natural', descricao: 'Suco de laranja natural', preco: 6.0 },
  { nome: 'Água', descricao: 'Água mineral', preco: 3.0 },
  { nome: 'Cerveja', descricao: 'Cerveja artesanal', preco: 10.0 },
  { nome: 'Chá Gelado', descricao: 'Chá gelado de limão', preco: 5.0 }
])

Categoria.find_by(nome: 'Sobremesas').produtos.create([
  { nome: 'Sorvete', descricao: 'Sorvete de baunilha', preco: 8.0 },
  { nome: 'Brownie', descricao: 'Brownie de chocolate com nozes', preco: 9.0 },
  { nome: 'Cheesecake', descricao: 'Cheesecake com calda de frutas vermelhas', preco: 10.0 },
  { nome: 'Pudim', descricao: 'Pudim de leite condensado', preco: 7.0 },
  { nome: 'Torta de Maçã', descricao: 'Torta de maçã com canela', preco: 11.0 }
])

Cliente.create!([
  {
    nome: "Aristóteles",
    data_nascimento: "1980-01-01",
    cpf: "12345678901",
    email: "aristoteles@example.com",
    senha: BCrypt::Password.create('password')
  },
  {
    nome: "Platão",
    data_nascimento: "1982-05-20",
    cpf: "23456789012",
    email: "platao@example.com",
    senha: BCrypt::Password.create('password')
  },
  {
    nome: "Sócrates",
    data_nascimento: "1975-12-15",
    cpf: "34567890123",
    email: "socrates@example.com",
    senha: BCrypt::Password.create('password')
  },
  {
    nome: "Immanuel Kant",
    data_nascimento: "1990-03-10",
    cpf: "45678901234",
    email: "kant@example.com",
    senha: BCrypt::Password.create('password')
  },
  {
    nome: "Bertrand Russell",
    data_nascimento: "1985-07-30",
    cpf: "56789012345",
    email: "bertrand.russell@example.com",
    senha: BCrypt::Password.create('password')
  }
])