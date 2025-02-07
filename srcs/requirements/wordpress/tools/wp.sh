#!/bin/sh

# Espera a que la base de datos esté lista
echo "Waiting for database to be ready..."
while ! nc -z $DB_HOST 3306; do   
  sleep 1 # espera 1 segundo antes de volver a comprobar
done
echo "Database is ready!"

# Verifica si el archivo de configuración de php-fpm existe (debería existir después de instalar php-fpm),
# luego reemplaza la línea que comienza con "listen = " por "listen = 0.0.0.0:9000" para que escuche solicitudes en el puerto 9000.
if [ -f /etc/php/7.4/fpm/pool.d/www.conf ]; then
    sed -i '/^listen = /s/.*/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf
    echo "Successfully edited www.conf: Listening on port 9000."
else
    echo "Error: www.conf file doesn't exist"
fi

# Verifica si el archivo de configuración de WordPress existe (esta vez no debería existir ya que aún no hemos descargado WordPress),
# después de verificar, descarga e instala WordPress con las credenciales pasadas en el archivo .env.
if [ ! -f ./wp-config.php ]; then
    wp core download --locale=en_US --allow-root
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST --dbprefix=$DB_PREFIX --allow-root
    wp core install --url=$DOMAIN_NAME --title="$WP_TITLE" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASS --allow-root
    wp theme install twentysixteen --activate --allow-root
fi

# Ejecuta php-fpm con la bandera -F para que no se ejecute en modo separado,
# se ejecutará en primer plano y mostrará los flujos de error y salida en la terminal.
echo "Executing php-fpm7.4 -F..."
/usr/sbin/php-fpm7.4 -F