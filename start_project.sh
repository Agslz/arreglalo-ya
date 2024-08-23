#!/bin/bash

# Mostrar mensaje inicial
echo "Iniciando la configuración del proyecto..."

# 1. Verificar si Docker está instalado
if ! [ -x "$(command -v docker)" ]; then
  echo "Error: Docker no está instalado." >&2
  exit 1
fi

# 2. Verificar si Docker Compose está instalado
if ! [ -x "$(command -v docker-compose)" ]; then
  echo "Error: Docker Compose no está instalado." >&2
  exit 1
fi

# 3. Cargar las variables de entorno desde el archivo .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "Error: El archivo .env no se encontró." >&2
  exit 1
fi

# 4. Construir la imagen de la aplicación
echo "Construyendo la imagen de la aplicación..."
docker-compose build

# 5. Levantar los contenedores con Docker Compose
echo "Levantando los contenedores..."
docker-compose up -d

# 6. Mostrar mensaje final
echo "El proyecto ha sido levantado correctamente."
echo "Puedes acceder a la aplicación en http://localhost:8080"
echo "Puedes acceder a phpMyAdmin en http://localhost:8081"

# 7. Verificar el estado de los contenedores
docker ps

# Fin del script
