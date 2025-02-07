# Usa la imagen base de Debian versión 11.9
FROM debian:11.9

# Actualiza la lista de paquetes e instala curl, php7.4-mysql, php7.4-fpm y netcat
RUN apt-get update -y && \
        apt-get install -y curl php7.4-mysql php7.4-fpm netcat

# Descarga wp-cli.phar, le otorga permisos de ejecución y lo mueve a /usr/local/bin/wp
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
        chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Copia el archivo de configuración www.conf desde el host al contenedor
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/

# Crea el directorio /run/php si no existe
RUN mkdir -p /run/php

# Otorga permisos 755 al directorio /run/php
RUN chmod 755 /run/php

# Copia el script wp.sh desde el host al contenedor
COPY ./tools/wp.sh /usr/local/bin/wp.sh

# Otorga permisos de ejecución al script wp.sh
RUN chmod +x /usr/local/bin/wp.sh

# Expone el puerto 9000, utilizado por PHP-FPM para aceptar conexiones
EXPOSE 9000

# Establece el directorio de trabajo en /var/www/html/
WORKDIR /var/www/html/

# Especifica el script de inicio que se ejecutará cuando el contenedor se inicie
ENTRYPOINT [ "/usr/local/bin/wp.sh" ]