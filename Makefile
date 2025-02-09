#-f flag -> specify the name and path of one or more compose files

#-d detach -> run containers in the background

D_PS = $(docker ps -aq)
D_IMG = $(docker images -q)

all: up

up:
	mkdir -p /home/$(USER)/data/wordpress
	mkdir -p /home/$(USER)/data/mysql
	docker-compose -f ./srcs/docker-compose.yml up -d --build

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean:
	docker-compose -f ./srcs/docker-compose.yml rm
	rm -rf /home/$(USER)/data/mysql/*
	rm -rf /home/$(USER)/data/wordpress/*

ps:
	docker-compose -f ./srcs/docker-compose.yml ps

logs:
	docker logs mariadb
	docker logs wordpress
	docker logs nginx

fclean: down clean
	docker stop ${D_PS} || true
	docker rm ${D_PS} || true
	docker rmi ${D_IMG} || true
	docker system prune -af --volumes || true
	docker volume rm srcs_wordpress || true
	docker volume rm srcs_mariadb || true

re: fclean up

.PHONY: all up stop down clean ps logs fclean re