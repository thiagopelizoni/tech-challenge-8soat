# Dicionário de Linguagem Ubíqua

# Entidades

* Cliente: Pessoa que realiza um pedido.
* Pedido: Conjunto de itens (produtos) solicitados por um cliente.
* Produto: Item individual disponível para venda.
* Categoria: Agrupamento lógico de produtos.
* Pagamento: Registro do pagamento de um Pedido.

# Categorias

* Categoria de Produto: Conjunto de produtos agrupados por semelhança, como sanduíches, bebidas, sobremesas.
* Promoção: Conjunto de produtos oferecidos a um preço promocional ou com desconto.

# Pedidos

* Painel de Pedidos: Tela onde os pedidos em andamento são exibidos para a equipe da cozinha.
* Fila de Espera: Lista de pedidos aguardando para serem preparados.
* Número do Pedido: Identificador único de um pedido.
* Recebido: Estado do pedido após o pagamento e confirmação, aguardando início do preparo.
* Em Andamento: Pedido que está sendo preparado pela cozinha.
* Pronto: Pedido finalizado pela cozinha, pronto para ser retirado pelo cliente.
* Finalizado: Pedido entregue ao cliente.
* Cancelado: Pedido que foi cancelado pelo cliente ou pelo sistema antes de ser finalizado.

# Clientes

* Cliente Registrado: Cliente que possui cadastro no sistema.
* Cliente Anônimo: Cliente que realiza um pedido sem estar registrado no sistema.
* Histórico de Pedidos: Registro de todos os pedidos feitos por um cliente específico.
* Fidelidade: Programa de pontos ou recompensas para clientes frequentes

# Produtos

* Produto: Item disponível para compra, como um sanduíche, bebida ou sobremesa.
* Disponível: Produto que está atualmente disponível para pedido.
* Indisponível: Produto que não pode ser pedido, geralmente devido à falta de estoque.
* Opção de Personalização: Possibilidade de personalizar um produto, como adicionar ou remover * ingredientes.
* Combo: Conjunto de produtos vendidos juntos a um preço reduzido.

# Outros Termos Relevantes
* Totem de Pedido: Terminal onde o cliente pode realizar pedidos de forma autônoma.
* Pagamento: Processo de finalização da compra, que pode ser realizado através de diferentes métodos como cartão de crédito, débito, ou dinheiro.
* Cupom Fiscal: Documento emitido após o pagamento confirmando a compra.
* Tempo de Preparo: Estimativa de tempo necessário para a cozinha preparar o pedido.
* Fila de Pedidos: Ordem sequencial em que os pedidos são preparados e entregues.

# Políticas

* DisponibilidadeDeProduto: Verifica se um produto está disponível em estoque antes de adicioná-lo ao pedido.
* LimiteDeItensPorPedido: Define um limite máximo de itens que podem ser adicionados a um pedido.
* TempoMaximoDePreparo: Define um tempo máximo para o preparo de um pedido.
* PolíticaDeCancelamento: Define as regras para o cancelamento de um pedido.

# Comandos

* CriarPedido: Inicia um novo pedido.
* AdicionarItem: Adiciona um produto ao pedido.
* RemoverItem: Remove um produto do pedido.
* ConfirmarPedido: Confirma o pedido e prossegue para o pagamento.
* RealizarPagamento: Efetua o pagamento do pedido.
* EnviarPedidoParaCozinha: Envia o pedido para a cozinha para preparo.
* MarcarPedidoComoPronto: Marca o pedido como pronto para retirada/entrega.
* MarcarPedidoComoEntregue: Marca o pedido como entregue ao cliente.
* CancelarPedido: Cancela o pedido.

# Eventos de Domínio

* PedidoCriado: Um novo pedido foi iniciado pelo cliente.
* ItemAdicionado: Um produto foi adicionado ao pedido.
* ItemRemovido: Um produto foi removido do pedido.
* PedidoConfirmado: O cliente confirmou o pedido e prosseguiu para o pagamento.
* PagamentoRealizado: O pagamento do pedido foi efetuado com sucesso.
* PedidoEnviadoParaCozinha: O pedido foi enviado para a cozinha para preparo.
* PedidoPronto: O pedido está pronto para ser retirado/entregue.
* PedidoEntregue: O pedido foi entregue ao cliente.
* PedidoCancelado: O pedido foi cancelado pelo cliente ou pelo sistema.

# Objetos de Valor

* ItemPedido: Representa um produto individual dentro de um pedido, com quantidade e personalizações (se aplicável).
* Atributos: Produto, Quantidade, Personalizações, Preço Unitário, Preço Total.
* Endereço: Endereço de entrega do pedido (opcional).
* Atributos: Logradouro, Número, Complemento, Bairro, Cidade, Estado, CEP.
* Forma de Pagamento: Método de pagamento utilizado pelo cliente.
* Atributos: Tipo (dinheiro, cartão, voucher, etc.), Detalhes (bandeira do cartão, número do voucher, etc.).