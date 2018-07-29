#!/usr/bin/env bash

rm -rf ./out

docker build . -t switch-compiler:latest

docker run -ti -v $(pwd)/out:/switch/out switch-compiler:latest
