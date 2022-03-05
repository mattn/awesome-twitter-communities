@echo off

docker run --workdir /root -v %CD%:/root --rm -it mattn/sort-awesome-twitter-communities:latest
