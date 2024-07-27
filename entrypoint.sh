#!/bin/bash
set -e

function check_db_initialized {
  if [[ $(rails db:version) ]]; then
    return 0
  else
    return 1
  fi
}

if check_db_initialized; then
  echo "Banco de dados já inicializado"
else
  echo "Inicializando banco de dados"
  rails db:create
  rails db:migrate
  rails db:seed
fi

exec "$@"