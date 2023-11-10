build:
	@docker build -t youtube:dev --network=hots .

stop:
	@docker stop youtube-dev

sh:
	@docker run -it --rm --net=host -v "${PWD}:/usr/src/app" --name youtube-dev  youtube:dev sh
