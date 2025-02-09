#!/bin/bash

# Crea certificados TLS para enviar datos a través de HTTPS
echo "Creando certificado SSL..."
if [ ! -f /etc/ssl/certs/nginx.crt ]; then
    # Si el archivo de certificado no existe, crea un nuevo certificado SSL autofirmado
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=ES/ST=Catalonia/L=Barcelona/O=42 Barcelona/CN=agheredi.42.fr"
fi
echo "Creación exitosas de certificado SSL!"

# Ejecuta el comando pasado como argumento al script
exec "$@"