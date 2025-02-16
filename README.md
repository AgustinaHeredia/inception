# Inception
## Descripción 
El proyecto Inception de 42 consiste en desplegar una infraestructura de contenedores utilizando Docker y Docker Compose. El objetivo principal es configurar múltiples servicios de manera modular siguiendo las mejores prácticas de contenedorización.

📌 Objetivos principales:
Configurar un entorno basado en Docker Compose con múltiples contenedores.
Implementar un servidor NGINX con SSL/TLS.
Configurar un servicio de base de datos con MariaDB.
Desplegar una aplicación WordPress usando PHP-FPM.
Manejar volúmenes para garantizar la persistencia de datos.
Asegurar que todos los servicios interactúen a través de una red de Docker.
Este proyecto ayuda a comprender los conceptos de virtualización, contenedorización y automatización de despliegues dentro de un entorno controlado.

## El proyecto
Este proyecto consiste en la configuración de una infraestructura compuesta por varios servicios utilizando `docker-compose`. La configuración se realiza de manera modular, asegurando la persistencia de datos y el uso de contenedores independientes.

## Tecnologías Utilizadas
- Docker
- Docker Compose
- NGINX
- WordPress con PHP-FPM
- MariaDB
- OpenSSL (para SSL/TLS)

## Estructura del Proyecto
```
📂 inception/
 ├── 📂 srcs/
 |   ├── requirements/
 │   |  ├── 📂 nginx/
 │   |  ├── 📂 wordpress/
 │   |  ├── 📂 mariadb/
 │   |  ├── 📜 docker-compose.yml
 ├── 📜 Makefile
```

## Instalación y Configuración
### 1. Clonar el Repositorio
```sh
git clone git@github.com:AgustinaHeredia/inception.git
cd inception
```

### 2. Construcción y Ejecución
Ejecuta el siguiente comando para crear y ejecutar los contenedores:
```sh
make
```

Para detener y eliminar los contenedores:
```sh
make clean
```

### 3. Verificación
#### Comprobación de Contenedores
```sh
docker compose ps
```
Todos los contenedores deben estar en estado `UP`.

#### Verificación de la Red de Docker
```sh
docker network ls
```
Debe aparecer una red dedicada para los servicios del proyecto.

#### Verificación de Volúmenes
```sh
docker volume ls
docker volume inspect <nombre-del-volumen>
```
El volumen de WordPress y MariaDB debe estar en `/home/login/data/`.

## Funcionalidades Principales
- **NGINX**: Servidor web configurado con SSL/TLS (puerto 443).
- **WordPress**: CMS con base de datos en MariaDB y persistencia de datos.
- **MariaDB**: Base de datos con credenciales seguras y acceso restringido.

## Seguridad Implementada
- El acceso al sitio web solo es posible a través de `https://login.42.fr`.
- No se puede acceder a través de `http://` (puerto 80 bloqueado).
- Uso de certificados SSL/TLS auto-firmados para la comunicación segura.

## Requisitos de Evaluación
### Explicaciones Clave
1. **Docker & Docker Compose**: Diferencia entre imágenes Docker usadas con y sin `docker-compose`.
2. **Beneficio de Docker frente a Máquinas Virtuales**.
3. **Estructura de directorios y archivos del proyecto**.
4. **Explicación sobre Docker Networks**.

### Comandos Clave para la Evaluación
#### Verificar Persistencia tras Reinicio
```sh
reboot
# Luego, iniciar docker-compose nuevamente
make
```
#### Acceder a la Base de Datos
```sh
docker exec -it mariadb_container mysql -u <usuario> -p
```
Debe solicitar contraseña y no permitir acceso sin ella.

## Autor
[Tu Nombre](https://github.com/AgustinaHeredia)
