#!/bin/bash
IMAGE_NAME="debiannginxphp7"
TAG_VERSION="2.0"
docker build -t $IMAGE_NAME:$TAG_VERSION .