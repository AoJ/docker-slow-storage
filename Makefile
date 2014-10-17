# Project: slow storage
# Author: AooJ <aooj@n13.cz>
# Date: 2014
# usage:
#	make build	- build new image from Dockerfile
#	make debug	- debug run already created image and attach to it
#	make try	- build and run in debug mode
#	make remove	- discarding current running production container

NAME=aooj/slow-storage
ID=slow-storage
VERSION=1.0

build:
	docker build -t $(NAME):$(VERSION) .


debug:
	docker run --cap-add mknod --cap-add sys_admin --device=/dev/fuse -e "LOCAL_DIR=/data" -e "REMOTE_DIR=storage-tmp" --entrypoint="/bin/bash" -v $(shell echo $(HOME)).ssh/id_rsa:/root/.ssh/id_rsa:ro -v $(shell echo $(HOME)).ssh/known_hosts:/root/.ssh/known_hosts:ro --rm -ti $(NAME):$(VERSION) -c /bin/bash

remove:
	docker kill $(ID) > /dev/null 2>&1
	docker rm $(ID) > /dev/null 2>&1

run:
	docker run --cap-add mknod --cap-add sys_admin --device=/dev/fuse -h $(ID) --name $(ID) -e "LOCAL_DIR=/data" -e "REMOTE_DIR=storage" -v $(shell echo $(HOME)).ssh/id_rsa:/root/.ssh/id_rsa:ro -v $(shell echo $(HOME)).ssh/known_hosts:/root/.ssh/known_hosts:ro -d $(NAME):$(VERSION)


try: build debug


.PHONY: build debug run remove try

