DOCKER_FILE = Dockerfile
COMPOSE_FILE = docker-compose.yml
IMAGE_TAG = mailer1:latest

image:
	docker build --no-cache -f $(DOCKER_FILE) -t $(IMAGE_TAG) . 

start:
	docker-compose -f $(COMPOSE_FILE) up -d

stop:
	docker-compose -f $(COMPOSE_FILE) down

shell:
	docker exec -itu root $(IMAGE_TAG) /bin/bash

rmi:
	docker rmi $(IMAGE_TAG)


.PHONY: image shell rmi start stop
