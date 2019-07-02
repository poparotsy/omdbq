#!/usr/bin/env bash

omdbUrl='https://www.omdbapi.com/?i=tt3896198&apikey=7eff34ec&t='
repo="omdbapi"
movie=$1

buildDockerfile() {
        dFile="Dockerfile.build"
        echo -e "FROM node \n" > $dFile
        echo -e "ENV omdbUrl=$omdbUrl\n" >> $dFile
        echo -e "WORKDIR /app\n" >> $dFile
        echo -e "COPY qomdb.js /app\n" >> $dFile
        echo -e "ENTRYPOINT [\"node\", \"qomdb.js\"]" >> $dFile
}


imageFound=$(docker images | grep $repo);

if [ -z "$1" ]; then
	echo -e "\n============================================"
	echo -e "Usage $0 \"movie name\""
	echo -e "Otherwise OMDB will reply with a random movie"
	echo -e "=============================================\n"
fi

if [ -z "$imageFound" ]; then

	echo -e "Building image..."
	buildDockerfile
	docker build -q -t $repo:latest -f $dFile .
	docker run --env movie="$movie" $repo:latest
	else
	docker run --env movie="$movie" $repo:latest
fi
