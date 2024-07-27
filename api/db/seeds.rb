# Categorias e Produtos
Categoria.find_or_create_by!(nome: 'Lanches').tap do |categoria|
  categoria.produtos.find_or_create_by!(nome: 'Hamburguer', descricao: 'Hamburguer de carne com queijo', preco: 15.0)
  categoria.produtos.find_or_create_by!(nome: 'Sanduíche Natural', descricao: 'Sanduíche de frango com alface', preco: 12.0)
  categoria.produtos.find_or_create_by!(nome: 'Cachorro Quente', descricao: 'Cachorro quente com molho especial', preco: 10.0)
  categoria.produtos.find_or_create_by!(nome: 'Taco', descricao: 'Taco mexicano com carne moída', preco: 18.0)
  categoria.produtos.find_or_create_by!(nome: 'Wrap', descricao: 'Wrap de frango com legumes', preco: 14.0)
end

Categoria.find_or_create_by!(nome: 'Acompanhamentos').tap do |categoria|
  categoria.produtos.find_or_create_by!(nome: 'Batata Frita', descricao: 'Batata frita crocante', preco: 8.0)
  categoria.produtos.find_or_create_by!(nome: 'Onion Rings', descricao: 'Anéis de cebola empanados', preco: 9.0)
  categoria.produtos.find_or_create_by!(nome: 'Salada Caesar', descricao: 'Salada Caesar com frango', preco: 12.0)
  categoria.produtos.find_or_create_by!(nome: 'Mozzarella Sticks', descricao: 'Palitos de queijo empanados', preco: 11.0)
  categoria.produtos.find_or_create_by!(nome: 'Sopa do Dia', descricao: 'Sopa do dia', preco: 7.0)
end

Categoria.find_or_create_by!(nome: 'Bebidas').tap do |categoria|
  categoria.produtos.find_or_create_by!(nome: 'Refrigerante', descricao: 'Refrigerante gelado', preco: 5.0)
  categoria.produtos.find_or_create_by!(nome: 'Suco Natural', descricao: 'Suco de laranja natural', preco: 6.0)
  categoria.produtos.find_or_create_by!(nome: 'Água', descricao: 'Água mineral', preco: 3.0)
  categoria.produtos.find_or_create_by!(nome: 'Cerveja', descricao: 'Cerveja artesanal', preco: 10.0)
  categoria.produtos.find_or_create_by!(nome: 'Chá Gelado', descricao: 'Chá gelado de limão', preco: 5.0)
end

Categoria.find_or_create_by!(nome: 'Sobremesas').tap do |categoria|
  categoria.produtos.find_or_create_by!(nome: 'Sorvete', descricao: 'Sorvete de baunilha', preco: 8.0)
  categoria.produtos.find_or_create_by!(nome: 'Brownie', descricao: 'Brownie de chocolate com nozes', preco: 9.0)
  categoria.produtos.find_or_create_by!(nome: 'Cheesecake', descricao: 'Cheesecake com calda de frutas vermelhas', preco: 10.0)
  categoria.produtos.find_or_create_by!(nome: 'Pudim', descricao: 'Pudim de leite condensado', preco: 7.0)
  categoria.produtos.find_or_create_by!(nome: 'Torta de Maçã', descricao: 'Torta de maçã com canela', preco: 11.0)
end

# Clientes
clientes = [
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
]

clientes.each do |cliente_attrs|
  Cliente.find_or_create_by!(cpf: cliente_attrs[:cpf]) do |cliente|
    cliente.nome = cliente_attrs[:nome]
    cliente.data_nascimento = cliente_attrs[:data_nascimento]
    cliente.email = cliente_attrs[:email]
    cliente.senha = cliente_attrs[:senha]
  end
end

# Gerar Pedidos
status_options = %w[recebido em_preparacao pronto finalizado]

lanches = Categoria.find_by(nome: 'Lanches').produtos
bebidas = Categoria.find_by(nome: 'Bebidas').produtos
sobremesas = Categoria.find_by(nome: 'Sobremesas').produtos

clientes = Cliente.all

20.times do
  cliente = clientes.sample
  produtos = (lanches.sample(rand(1..3)) + bebidas.sample(rand(1..2)) + sobremesas.sample(rand(1..2))).map(&:id)
  Pedido.create!(
    cliente: [cliente, nil].sample,
    produtos: produtos,
    status: status_options.sample,
    observacao: "Observação do pedido"
  )
end

# Pedidos com cliente nulo
2.times do
  produtos = (lanches.sample(rand(1..3)) + bebidas.sample(rand(1..2)) + sobremesas.sample(rand(1..2))).map(&:id)
  Pedido.create!(
    cliente: nil,
    produtos: produtos,
    status: status_options.sample,
    observacao: "Observação do pedido"
  )
end
