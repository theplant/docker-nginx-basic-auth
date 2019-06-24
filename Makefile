default: build

docker-image = theplant/nginx-basic-auth
docker-tag = 1.0

build:
	docker build --squash \
		-t $(docker-image):$(docker-tag) \
		.

push: build
	docker push $(docker-image):$(docker-tag)

show-images:
	docker images | grep "$(docker-image)"

# Remove dangling images
clean-images:
	docker images -a -q \
		--filter "reference=$(docker-image)" \
		--filter "dangling=true" \
	| xargs docker rmi

# Remove all images
clear-images:
	docker images -a -q \
		--filter "reference=$(docker-image)" \
	| xargs docker rmi
