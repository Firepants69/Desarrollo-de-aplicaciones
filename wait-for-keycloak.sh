#!/bin/bash

HOST=$1
shift
CMD=$@

until curl --silent --fail "$HOST"; do
  echo "Esperando a que Keycloak esté disponible..."
  sleep 5
done

echo "Keycloak está disponible. Iniciando la aplicación..."
exec $CMD
