FROM debian:11.9

# Actualiza apt-get e instale los paquetes necesarios
RUN apt-get update -y \ 
		&& apt-get upgrade -y \
		&& apt-get install mariadb-server -y

# Exponer el puerto 3306, utilizado por MYSQL para realizar conexiones
EXPOSE 3306

# Copiar la configuración de mariadb, esta configuración anulará la configuración predeterminada
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copiar el script desde la máquina host al contenedor
COPY tools/mariadb.sh /usr/local/bin/mariadb.sh

# otorga permisos de ejecución al script mariadb.sh en el contenedor
RUN chmod a+x /usr/local/bin/mariadb.sh

# Crea /var/run/mysqld si no existe, MySQL lo necesita para almacenar archivos de socket y PID
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 775 /var/run/mysqld

# Ejecuta script cuando el contenedor esté listo
ENTRYPOINT ["/bin/bash", "/usr/local/bin/mariadb.sh"]