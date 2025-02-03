# Detecta el sistema operativo
UNAME_S := $(shell uname -s)

# Define las rutas de los directorios de datos según el sistema operativo
ifeq ($(UNAME_S), Darwin)
    DATA_DIR := /Users/$(USER)/data
else
    DATA_DIR := /home/$(USER)/data
endif

all: up

up:
	mkdir -p $(DATA_DIR)/wordpress
	mkdir -p $(DATA_DIR)/mariadb
	docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker-compose -f ./srcs/docker-compose.yml down

re: down up

clean:
	rm -rf $(DATA_DIR)/mysql/*
	rm -rf $(DATA_DIR)/wordpress/*
	-docker stop $$(docker ps -qa)
	-docker rm $$(docker ps -qa)
	-docker rmi $$(docker images -qa)
	-docker volume rm $$(docker volume ls -q)
	-docker network rm agheredinet

.PHONY: all up down re clean