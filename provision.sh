#!/bin/bash

# Atualiza os pacotes
apt-get update

# Instala o servidor web (Nginx)
apt-get install -y nginx

# Configuração do Nginx
echo "Configurando Nginx..."

# Reinicia o serviço do Nginx
service nginx restart

echo "Provisionamento concluído."
