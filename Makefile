compose_file = docker-compose.yml
container_name = news-crawler

build:
	docker-compose -f $(compose_file) build

up:
	docker-compose -f $(compose_file) up -d

logs:
	docker logs $(container_name) -f
