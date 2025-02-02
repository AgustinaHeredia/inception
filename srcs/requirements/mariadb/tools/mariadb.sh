# filepath: /Users/agusheredia/Desktop/inception/srcs/requirements/mariadb/tools/mariadb.sh
#!/bin/sh

# Inicia el servicio de MariaDB
service mysql start

# Espera a que el servicio de MariaDB esté listo
while ! mysqladmin ping -h "localhost" --silent; do
    sleep 1
done

# Ejecuta los comandos SQL
mysql -u root -p${DB_ROOT_PASS} <<-EOSQL
    CREATE DATABASE IF NOT EXISTS ${DB_NAME};
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
EOSQL

# Mantén el contenedor en ejecución
tail -f /dev/null