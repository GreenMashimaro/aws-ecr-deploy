#!/bin/bash

source variables.sh

imageNameAndTag=$reponsitoryName:$version

targetImageAndTag=$awsAccountId.dkr.ecr.$region.amazonaws.com/$imageNameAndTag

echo "version=$version";

# Platform architecture selection arm64
docker build --build-arg ARG_VERSION=$version --platform=linux/arm64 -t $imageNameAndTag ../

docker image ls;

echo "\nbuild tag\n"

docker tag $imageNameAndTag $targetImageAndTag;

echo "\npush to origin\n"

docker push $targetImageAndTag;

echo "\nrun(lambda update-function-code --image-uri $targetImageAndTag)\n"

aws lambda update-function-code \
  --function-name $lambdaFunctionName \
  --image-uri $targetImageAndTag \
  > /dev/null 2>&1 || echo "update aws lambda function $lambdaFunctionName error"
