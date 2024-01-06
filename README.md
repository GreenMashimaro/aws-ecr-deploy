# AWS ECR DEPLOY AND UPDATE LAMBDA FUNCTION

## USAGE

1. aws login

``` shell
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${awsAccountId}.dkr.ecr.${region}.amazonaws.com
```

2. copy ./_variables.sh to ./variables.sh

    and then modify variables.sh

3. run `npm run build`

# AWS ECR

https://docs.aws.amazon.com/zh_cn/AmazonECR/latest/userguide/what-is-ecr.html

# RELATED DOCUMENTS

https://aws.amazon.com/cn/cli/

https://docs.aws.amazon.com/zh_cn/AmazonECR/latest/userguide/getting-started-cli.html

https://www.runoob.com/docker/docker-container-usage.html

https://awscli.amazonaws.com/v2/documentation/api/2.1.29/reference/lambda/update-function-code.html
