all: build run

build:
	docker build --no-cache -t sonarr .

run:
	docker run -d --restart always --link transmission:transmission -p 8989:8989 --volumes-from config --volumes-from data --name sonarr sonarr
	
rm:
	docker rm -f sonarr


.PHONY: build run rm
