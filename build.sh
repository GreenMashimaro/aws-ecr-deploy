#!/bin/bash

# 获取 $mode 参数
while [ "$#" -gt 0 ]; do
  case "$1" in
    --mode)
      # 如果 --mode 后有参数，则将其赋值给 mode 变量
      if [ "$#" -gt 1 ]; then
        mode="$2"
        echo "The value of the Mode variable is: $mode"
      else
        echo "Error: Missing parameter value after -- mode."
        exit 1
      fi
      shift 2
      ;;
    *)
      # 其他未知参数，你可以根据需要添加处理逻辑
      echo "Unknown parameter: $1"
      exit 1
      ;;
  esac
done

if [ "$mode" = "production" ]; then
  source variables.sh
else
  # Can be changed to other environment variables
  source variables.sh
fi

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
