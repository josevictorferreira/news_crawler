compose_file = ops/production/docker-compose.yml

up:
	docker-compose -f $(compose_file) up -d
