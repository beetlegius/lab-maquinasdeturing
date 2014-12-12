#!/bin/bash
if [ -z "$1" ]; then
  echo "Debe especificar un mensaje!"
else
  echo "Limpiando logs..."
  rake log:clear

  echo "Limpiando temporales..."
  rm -rf tmp

  echo "Agregando todos los archivos al repositorio..."
  git add -A

  echo "Commiteando los cambios...\n"
  git commit -am "$1"

  echo "\nPUSHEANDO...\n"
  git push heroku master

  echo "\nCorriendo el servidor..."
  rails s
fi
