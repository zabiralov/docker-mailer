DOCKER_FILE = Dockerfile
COMPOSE_FILE = docker-compose.yml
IMAGE_TAG = mailer1:latest

build:
	docker build --no-cache -f $(DOCKER_FILE) -t $(IMAGE_TAG) . 

up:
	docker-compose -f $(COMPOSE_FILE) up -d

down:
	docker-compose -f $(COMPOSE_FILE) down

clean:
	docker rmi $(IMAGE_TAG)


.PHONY: build up down clean
