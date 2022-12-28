build:
	@docker build -t youtube:dev .

run:
	@docker run -it \
	--net=host \
	-v "${PWD}:/usr/src/app" \
	--name youtube-dev \
	--rm youtube:dev \
	youtube-dl -o '/usr/src/app/downloads/teste.mp4' https://www.youtube.com/watch?v=7E-cwdnsiow

stop:
	@docker stop youtube-dev

sh:
	@docker exec -it youtube-dev sh

test:
	@docker run -it \
	--net=host \
	-v "${PWD}:/usr/src/app" \
	--name facebook-news-publisher-dev \
	--rm facebook-news-publisher:dev \
	npm test