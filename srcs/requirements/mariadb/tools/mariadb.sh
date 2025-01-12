#!/bin/bash

# Variables
DB_NAME="your_database_name"
DB_USER="your_database_user"
DB_PASSWORD="your_database_password"
DB_ROOT_PASSWORD="your_root_password"

# Update package list and install MariaDB
apt-get update
apt-get install -y mariadb-server

# Start MariaDB service
service mysql start

# Secure MariaDB installation
mysql_secure_installation <<EOF

y
$DB_ROOT_PASSWORD
$DB_ROOT_PASSWORD
y
n
y
y
EOF

# Create database and user
mysql -u root -p$DB_ROOT_PASSWORD <<EOF
CREATE DATABASE $DB_NAME;
CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

# Restart MariaDB service
service mysql restart

echo "MariaDB setup completed."