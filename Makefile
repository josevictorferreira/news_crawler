compose_file = docker-compose.yml

build:
	docker-compose -f $(compose_file) build

up:
	docker-compose -f $(compose_file) up -d
