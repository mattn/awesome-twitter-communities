#!/bin/sh

docker run --workdir /root -v $(pwd):/root --rm -it mattn/sort-awesome-twitter-communities:latest
