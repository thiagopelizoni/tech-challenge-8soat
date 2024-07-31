
Categoria.find_or_create_by!(nome: 'Lanches').tap do |categoria|
  categoria.produtos.find_or_create_by!(nome: 'Big Mac', descricao: 'Dois hambúrgueres, alface, queijo, molho especial, cebola e picles, em um pão com gergelim', preco: 20.0, status: 'ativo')
  categoria.produtos.find_or_create_by!(nome: 'Cheeseburger', descricao: 'Hambúrguer de carne com queijo, ketchup, mostarda, cebola e picles', preco: 10.0, status: 'ativo')
  categoria.produtos.find_or_create_by!(nome: 'McChicken', descricao: 'Hambúrguer de frango empanado com alface e maionese no pão com gergelim', preco: 15.0, status: 'ativo')
  categoria.produtos.find_or_create_by!(nome: 'Quarterão com Queijo', descricao: 'Hambúrguer de carne com queijo, ketchup, mostarda, cebola e picles', preco: 18.0, status: 'ativo')
  categoria.produtos.find_or_create_by!(nome: 'Cachorro Quente', descricao: 'Cachorro quente com molho especial', preco: 10.0, status: 'inativo')
  categoria.produtos.find_or_create_by!(nome: 'Taco', descricao: 'Taco mexicano com carne moída', preco: 18.0, status: 'inativo')
  categoria.produtos.find_or_create_by!(nome: 'Wrap', descricao: 'Wrap de frango com legumes', preco: 14.0, status: 'inativo')
end

# Acompanhamentos
Categoria.find_or_create_by!(nome: 'Acompanhamentos').tap do |categoria|
  categoria.produtos.find_or_create_by!(nome: 'Batata Frita', descricao: 'Batata frita crocante e salgada', preco: 8.0, status: 'ativo')
  categoria.produtos.find_or_create_by!(nome: 'McNuggets', descricao: 'Pedaços de frango empanados e fritos', preco: 12.0, status: 'ativo')
  categoria.produtos.find_or_create_by!(nome: 'Salada', descricao: 'Salada fresca com alface, tomate e cenoura', preco: 10.0, status: 'ativo')
  categoria.produtos.find_or_create_by!(nome: 'Salada Caesar', descricao: 'Salada Caesar com frango', preco: 12.0, status: 'inativo')
  categoria.produtos.find_or_create_by!(nome: 'Mozzarella Sticks', descricao: 'Palitos de queijo empanados', preco: 11.0, status: 'inativo')
  categoria.produtos.find_or_create_by!(nome: 'Sopa do Dia', descricao: 'Sopa do dia', preco: 7.0, status: 'inativo')
end

# Bebidas
Categoria.find_or_create_by!(nome: 'Bebidas').tap do |categoria|
  categoria.produtos.find_or_create_by!(nome: 'Coca-Cola', descricao: 'Refrigerante gelado', preco: 6.0, status: 'ativo')
  categoria.produtos.find_or_create_by!(nome: 'Suco de Laranja', descricao: 'Suco de laranja natural', preco: 7.0, status: 'ativo')
  categoria.produtos.find_or_create_by!(nome: 'Milkshake de Morango', descricao: 'Milkshake cremoso de morango', preco: 10.0, status: 'ativo')
  categoria.produtos.find_or_create_by!(nome: 'Suco Natural', descricao: 'Suco de laranja natural', preco: 6.0, status: 'inativo')
  categoria.produtos.find_or_create_by!(nome: 'Chá Gelado', descricao: 'Chá gelado de limão', preco: 5.0, status: 'inativo')
end

# Sobremesas
Categoria.find_or_create_by!(nome: 'Sobremesas').tap do |categoria|
  categoria.produtos.find_or_create_by!(nome: 'McFlurry', descricao: 'Sorvete de baunilha com cobertura e pedaços de chocolate', preco: 12.0, status: 'ativo')
  categoria.produtos.find_or_create_by!(nome: 'Torta de Maçã', descricao: 'Torta quente de maçã', preco: 7.0, status: 'ativo')
  categoria.produtos.find_or_create_by!(nome: 'Sundae de Chocolate', descricao: 'Sorvete de baunilha com cobertura de chocolate', preco: 9.0, status: 'ativo')
  categoria.produtos.find_or_create_by!(nome: 'Brownie', descricao: 'Brownie de chocolate com nozes', preco: 9.0, status: 'inativo')
  categoria.produtos.find_or_create_by!(nome: 'Cheesecake', descricao: 'Cheesecake com calda de frutas vermelhas', preco: 10.0, status: 'inativo')
  categoria.produtos.find_or_create_by!(nome: 'Pudim', descricao: 'Pudim de leite condensado', preco: 7.0, status: 'inativo')
  categoria.produtos.find_or_create_by!(nome: 'Torta de Maçã', descricao: 'Torta de maçã com canela', preco: 11.0, status: 'inativo')
end

# Clientes
clientes = [
  {
    nome: "Aristóteles",
    data_nascimento: "1980-01-01",
    cpf: "12345678901",
    email: "aristoteles@greek.com",
    senha: BCrypt::Password.create('password')
  },
  {
    nome: "Platão",
    data_nascimento: "1982-05-20",
    cpf: "23456789012",
    email: "platao@greek.com",
    senha: BCrypt::Password.create('password')
  },
  {
    nome: "Sócrates",
    data_nascimento: "1975-12-15",
    cpf: "34567890123",
    email: "socrates@greek.com",
    senha: BCrypt::Password.create('password')
  },
  {
    nome: "Immanuel Kant",
    data_nascimento: "1990-03-10",
    cpf: "45678901234",
    email: "kant@philosopher.com",
    senha: BCrypt::Password.create('password')
  },
  {
    nome: "Bertrand Russell",
    data_nascimento: "1985-07-30",
    cpf: "56789012345",
    email: "bertrand.russell@philosopher.com",
    senha: BCrypt::Password.create('password')
  },
  {
    nome: "Ludwig Wittgenstein",
    data_nascimento: "1985-10-12",
    cpf: "62367099049",
    email: "wittgenstein@philosopher.com",
    senha: BCrypt::Password.create('password')
  },
  {
    nome: "Tomás de Aquino",
    data_nascimento: "1979-06-12",
    cpf: "31759316008",
    email: "tomas.aquino@philosopher.com",
    senha: BCrypt::Password.create('password')
  },
  {
    nome: "Wolfgang Amadeus Mozart",
    data_nascimento: "1970-12-05",
    cpf: "55775930002",
    email: "wamozart@musician.com",
    senha: BCrypt::Password.create('password')
  },
  {
    nome: "Johann Sebastian Bach",
    data_nascimento: "1975-10-04",
    cpf: "85118401097",
    email: "bach@musician.com",
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
acompanhamentos = Categoria.find_by(nome: 'Acompanhamentos').produtos
bebidas = Categoria.find_by(nome: 'Bebidas').produtos
sobremesas = Categoria.find_by(nome: 'Sobremesas').produtos

clientes = Cliente.all

30.times do
  produtos = (
    lanches.sample(rand(1..3)) +
    bebidas.sample(rand(1..2)) +
    acompanhamentos.sample(1) +
    sobremesas.sample(rand(1..2))
  ).map(&:id)

  Pedido.create!(
    cliente: clientes.sample,
    produtos: produtos,
    pagamento: 'em_aberto',
    status: nil,
    observacao: nil,
  )

  Pedido.create!(
    cliente: clientes.sample,
    produtos: produtos,
    pagamento: 'efetuado',
    status: status_options.sample,
    observacao: "Observação do pedido"
  )
end

# Pedidos com cliente nulo
20.times do
  produtos = (
    lanches.sample(rand(1..3)) +
    bebidas.sample(rand(1..2)) +
    acompanhamentos.sample(1) +
    sobremesas.sample(rand(1..2))
  ).map(&:id)

  Pedido.create!(
    cliente: nil,
    produtos: produtos,
    pagamento: 'em_aberto',
    status: nil,
    observacao: nil
  )

  Pedido.create!(
    cliente: nil,
    produtos: produtos,
    pagamento: 'efetuado',
    status: status_options.sample,
    observacao: "Observação do pedido"
  )
end
