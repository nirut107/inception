
DIR = ./srcs/docker-compose.yml

all: up

up : 
	export PROJECT_PATH=$(pwd)
	docker-compose  -f ${DIR} up -d

down :
	docker-compose -f ./srcs/docker-compose.yml down -v --remove-orphans

build:
	docker-compose -f ${DIR} build --no-cache

clean: 
		rm -rf  ./srcs/my_app//volumes/*
		rm -rf  ./srcs/mariaDB/volumes/*
		rm -rf  ./srcs/wordpress/volumes/*
		docker system prune -af

re: down clean build up

.PHONY: up down build re