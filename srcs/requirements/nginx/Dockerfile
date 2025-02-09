# Usa la imagen base de Debian versión 11.9
FROM debian:11.9

# Actualiza la lista de paquetes e instala nginx y openssl
RUN apt -y update
RUN apt install -y nginx && apt install -y openssl

# Expone el puerto 443, utilizado para conexiones HTTPS
EXPOSE 443

# Copia el script de inicio de nginx desde el host al contenedor
COPY ./tools/nginx_start.sh /var/www/.
# Copia el archivo de configuración de nginx desde el host al contenedor
COPY ./conf/default /etc/nginx/sites-enabled/default

# Otorga permisos de ejecución al script de inicio de nginx
RUN chmod +x /var/www/nginx_start.sh

# Especifica el script de inicio que se ejecutará cuando el contenedor se inicie
ENTRYPOINT [ "var/www/nginx_start.sh" ]

# Comando por defecto para ejecutar nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]