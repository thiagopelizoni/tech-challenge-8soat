# Pos Tech FIAP | Software Arquitecture | 8SOAT

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

O vídeo com a apresentação dos entregáveis requeridos nesta fase pode ser acessado em https://youtu.be/4sS36rzY2zA.

## API

Lista de requisitos que a API deve contemplar nesta fase.

###  Checkout retornando a identificação do mesmo

* POST /pedidos

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
* PUT /pedidos/:id/receber
* PUT /pedidos/:id/preparar
* PUT /pedidos/:id/pronto
* PUT /pedidos/:id/finalizar

## Kubernetes

Na Fase 3, estes arquivos foram separados e encontram-se no repositório https://github.com/thiagopelizoni/tech-challenge-kubernetes.

## Arquitetura

https://miro.com/app/board/uXjVLT5mOMY=/