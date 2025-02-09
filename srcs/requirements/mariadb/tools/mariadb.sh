#!/bin/bash

# Crea el directorio /run/mysqld si no existe
mkdir -p /run/mysqld

# Cambia el propietario del directorio /run/mysqld al usuario y grupo mysql
chown mysql:mysql /run/mysqld

# Verifica si el directorio de la base de datos no existe
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Inicializando la base de datos..."
    # Inicializa la base de datos con mysql_install_db
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

# Inicia MariaDB en modo seguro y lo ejecuta en segundo plano
mysqld_safe --datadir='/var/lib/mysql' &
# Espera 5 segundos para asegurarse de que el servicio esté listo
sleep 5

# Conexión como root para configurar la base de datos y usuarios
echo "Configurando la base de datos y permisos..."
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
FLUSH PRIVILEGES;
EOF

# Apaga el servicio de MariaDB
mysqladmin -u ${DB_ROOT} --password=${DB_ROOT_PASS} shutdown

# Ejecuta MariaDB en modo consola para mantener el contenedor en ejecución
exec mysqld --user=mysql --console