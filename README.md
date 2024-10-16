# Tech Challenge 8SOAT

Tech Challenge do curso de [Pós-Graduação em Arquitetura de Software da FIAP](https://postech.fiap.com.br/curso/software-architecture/).

# Requisitos

* [Docker](https://docs.docker.com/engine/install/)
* [Docker Compose](https://github.com/docker/compose)
* [Minikube](https://k8s-docs.netlify.app/en/docs/tasks/tools/install-minikube/)

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

###  Checkout retornando a identificação do mesmo

* POST /pedidos

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

### Consultar o status do pagamento dos pedidos

* GET /pedidos/pagamento-em-aberto
* GET /pedidos/pagamento-confirmado
* GET /pedidos/pagamento-recusado

### Webhook para receber confirmação de pagamento

https://www.mercadopago.com.br/developers/panel/app/4174081168856284/webhooks

### Lista de Pedidos

* GET /pedidos/prontos
* GET /pedidos/em-preparacao
* GET /pedidos/recebidos
* GET /pedidos/finalizados

### Atualizar o status do Pedido

* PUT /pedidos/:id

```
curl -X 'PUT' \
  'http://localhost:3000/pedidos/298' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "status": "em_preparacao"
}'
```

* PUT /pedidos/:id/receber

``
curl -X 'PUT' 'http://localhost:3000/pedidos/298/receber' -H 'accept: */*'
``
* PUT /pedidos/:id/preparar

``
curl -X 'PUT' 'http://localhost:3000/pedidos/298/preparar' -H 'accept: */*'
``

* PUT /pedidos/:id/pronto

``
curl -X 'PUT' 'http://localhost:3000/pedidos/298/pronto' -H 'accept: */*'
``

* PUT /pedidos/:id/finalizar

``
curl -X 'PUT' 'http://localhost:3000/pedidos/298/finalizar' -H 'accept: */*'
``

# Kubernetes

Para subir a infraestrutura necessária deste projeto basta executar:

```
bash apply.sh
```

Para conferir se tudo está correto, basta executar os comandos abaixo:

```
kubectl get all
```

Para remover a infraestrutura, basta executar:

```
bash remove.sh
```

## Arquitetura

https://miro.com/app/board/uXjVLT5mOMY=/

# Apresentação

https://youtu.be/4sS36rzY2zA