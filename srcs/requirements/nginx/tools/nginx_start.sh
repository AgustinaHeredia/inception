#!/bin/bash

# Crea certificados TLS para enviar datos a través de HTTPS
echo "Creating SSL certificates..."
if [ ! -f /etc/ssl/certs/nginx.crt ]; then
    # Si el archivo de certificado no existe, crea un nuevo certificado SSL autofirmado
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=ES/ST=Catalonia/L=Barcelona/O=42/OU=Software/CN=agheredi.42.fr"
fi
echo "Successful creation of SSL certificates!"

# Ejecuta el comando pasado como argumento al script
exec "$@"