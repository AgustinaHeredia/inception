#!/bin/bash

# Crea certificados TLS para enviar datos a través de HTTPS
echo "Creando certificado SSL..."
#!/bin/bash
if [ ! -f ${SS_CERT} ]; then
	openssl req -newkey rsa:4096 -x509 -days 365 -nodes -out ${SS_CERT} -keyout ${SS_KEY} -subj "/C=ES/ST=Barcelona/L=Barcelona/O=42 Barcelona/CN=${DOMAIN_NAME}";
fi
echo "Creación exitosas de certificado SSL!"

# Ejecuta el comando pasado como argumento al script
exec "$@"