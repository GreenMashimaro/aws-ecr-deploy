#!/bin/bash

source variables.sh

imageNameAndTag=$reponsitoryName:$version

echo "version=$version";

# Platform architecture selection arm64
docker build --platform=linux/arm64 -t $imageNameAndTag .

docker image ls;

echo "\nbuild tag\n"

docker tag $imageNameAndTag $awsAccountId.dkr.ecr.$region.amazonaws.com/$imageNameAndTag;

echo "\npush to origin\n"

docker push $awsAccountId.dkr.ecr.$region.amazonaws.com/$imageNameAndTag;
