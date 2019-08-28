+++
title = "Setup Basic Services"
chapter = false
weight = 1
+++

### Introduction

Up until now, we have been going through various steps to setup our environment. Installing tools and other necessary steps to make sure we progress through the modules without any issues. Now, we are ready to begin deploying the infrastructure that will support our Unicorn Store application. 

### Basic Services CloudFormation Stack

We are going to setup some basic services such as an Amazon RDS Database, secrets in AWS Secrets Manager, AWS CodeCommit, and Amazon ECR services.  

{{% notice info %}}
This step takes approximately 15 minutes 
{{% /notice %}}

Copy and paste the following into Cloud9's terminal to launch a CloudFormation stack
```bash
cd ~/environment/modernization-devsecops-workshop/cfn

aws cloudformation create-stack --stack-name UnicornStoreServices --template-body file://unicorn-store-services.yaml --capabilities CAPABILITY_NAMED_IAM

until [[ `aws cloudformation describe-stacks --stack-name "UnicornStoreServices" --query "Stacks[0].[StackStatus]" --output text` == "CREATE_COMPLETE" ]]; do  echo "The stack is NOT in a state of CREATE_COMPLETE at `date`";   sleep 30; done && echo "The Stack is built at `date` - Please proceed"
```

The output should look like the window below
<pre>
The stack is NOT in a state of CREATE_COMPLETE at Sun Aug  4 05:09:55 UTC 2019
The stack is NOT in a state of CREATE_COMPLETE at Sun Aug  4 05:10:26 UTC 2019
The stack is NOT in a state of CREATE_COMPLETE at Sun Aug  4 05:10:56 UTC 2019
The Stack is built at Sun Aug  4 05:11:27 UTC 2019 - Please proceed
xxxyyy_user:~/environment/modernization-devsecops-workshop/cfn (master) $ 
</pre>