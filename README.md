# Tech Challenge 8SOAT

Tech Challenge do curso de [Pós-Graduação em Arquitetura de Software da FIAP](https://postech.fiap.com.br/curso/software-architecture/).

# Requisitos

* [Docker](https://docs.docker.com/engine/install/)
* [Docker Compose](https://github.com/docker/compose)

# Instalação

```
docker-compose up --build -d
```

A aplicação estará disponível em http://localhost:3000/.

# Fase 1

## DDD

* [Diagramas Event Storm](https://miro.com/app/board/uXjVK0LIAuE=/)
* [Dicionário de Linguagem Ubíqua](DICIONARIO.md)

## Swagger

* http://localhost:3000/api-docs

# Fase 2

## API

Lista de requisitos que a API deve contemplar nesta fase.

### Pedido

* Checkout retornando a identificação do mesmo:

```
curl -X 'POST' \
  'http://localhost:3000/pedidos' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
"valor": "75.0",
"pagamento": "em_aberto",
"cliente_id": 4,
"produtos": [3, 7, 2, 15, 13, 23, 22]
}'
```

* Consultar status pagamento pedido, informando se o pagamento foi aprovado ou não.

Para este caso, encontram-se implementadas as opções abaixo:

#### Pedidos com pagamento não confirmado

* GET /pedidos/em-aberto

#### Pedidos com pagamento confirmado

* GET /pedidos/pago