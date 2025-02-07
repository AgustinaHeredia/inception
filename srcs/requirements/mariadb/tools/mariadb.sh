#!/bin/bash

# Crea el directorio /run/mysqld si no existe
mkdir -p /run/mysqld

# Cambia el propietario del directorio /run/mysqld al usuario y grupo mysql
chown mysql:mysql /run/mysqld

# Verifica si el directorio de la base de datos no existe
if [ ! -d /var/lib/mysql/${DB_NAME} ]; then
    echo "Initializing the database.."
    # Inicializa la base de datos con mysql_install_db
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

# Inicia MariaDB en modo seguro y lo ejecuta en segundo plano
mysqld_safe --datadir='/var/lib/mysql' &
# Espera 5 segundos para asegurarse de que el servicio esté listo
sleep 5

# Verifica si el directorio de la base de datos no existe
if [ ! -d /var/lib/mysql/${DB_NAME} ]; then
    # Crea la base de datos
    mysql -u ${DB_ROOT} -p${DB_ROOT_PASS} -e "CREATE DATABASE ${DB_NAME};"
    # Crea un nuevo usuario con las credenciales proporcionadas
    mysql -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}'"
    # Otorga todos los privilegios al nuevo usuario en la base de datos creada
    mysql -e "GRANT ALL ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;"
    # Aplica los cambios de privilegios
    mysql -e "FLUSH PRIVILEGES;"
fi

# Apaga el servicio de MariaDB
mysqladmin -u ${DB_ROOT} --password=${DB_ROOT_PASS} shutdown

# Ejecuta MariaDB en modo consola para mantener el contenedor en ejecución
exec mysqld --user=mysql --console