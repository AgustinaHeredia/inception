#!/bin/bash

# Crea certificados TLS para enviar datos a través de HTTPS
echo "Creando certificado SSL..."
#!/bin/bash
if [ ! -f /etc/ssl/certs/nginx.crt ]; then
	openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=ES/ST=Barcelona/L=Barcelona/O=wordpress/CN=${DOMAIN_NAME}";
fi
echo "Creación exitosas de certificado SSL!"

# Ejecuta el comando pasado como argumento al script
exec "$@"