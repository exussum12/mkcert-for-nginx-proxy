.PHONY: build run publish

NAME=mkcert-for-nginx-proxy
NAMESPACE=aegypius

build:
	docker build -t ${NAMESPACE}/${NAME} .

run: build
	docker run --rm -e DEBUG=true \
		--name ${NAME} \
		--volume /var/run/docker.sock:/var/run/docker.sock:ro \
		--volume /var/run/docker.sock:/var/run/docker.sock:ro \
		-it ${NAMESPACE}/${NAME}

publish: build
	docker tag ${NAMESPACE}/${NAME} ${NAMESPACE}/${NAME}:`git rev-parse --short HEAD`
	docker push ${NAMESPACE}/${NAME}:`git rev-parse --short HEAD`