+++
title = "Cleanup"
chapter = false
weight = 10
+++

### Cleanup 
In order to prevent charges to your account we recommend cleaning up the infrastructure that was created. If you plan to keep things running so you can examine the workshop a bit more please remember to do the cleanup when you are done. It is very easy to leave things running in an AWS account, forget about it, and then accrue charges.

{{% notice info %}}
You will need to manually delete some resources before you delete the CloudFormation stacks so please do the following steps in order.  With the CloudFormation Stacks, delete one at a time and validate the stack is removed before deleting the next stack.
{{% /notice %}}

```bash
# Delete S3 Bucket
aws s3 rm s3://$(aws s3api list-buckets --query 'Buckets[?starts_with(Name, `unicornpipeline-artifactbucket`) == `true` ].Name' --output text) --recursive

# Delete Log Group
aws logs delete-log-group --log-group-name UnicornStore

# Delete ECR Repository
aws ecr delete-repository --repository-name modernization-devsecops-workshop --force

# Delete CloudFormation Stacks
aws cloudformation delete-stack --stack-name UnicornPipeline
aws cloudformation delete-stack --stack-name UnicornECS
aws cloudformation delete-stack --stack-name UnicornStoreServices
aws cloudformation delete-stack --stack-name UnicornDevSecOpsWorkshop

echo 'Completed cleanup.'
```



