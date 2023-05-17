#!/bin/bash

# Atualiza os pacotes
apt-get update

# Instala o servidor web (Nginx)
apt-get install -y nginx

# Configuração do Nginx
echo "Configurando Nginx..."
# Aqui você pode adicionar as configurações específicas do Nginx, como definir as regras de proxy reverso ou balanceamento de carga.

# Reinicia o serviço do Nginx
service nginx restart

echo "Provisionamento concluído."
