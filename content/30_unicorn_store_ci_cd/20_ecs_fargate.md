+++
title = "Deploy ECS Fargate Service"
chapter = false
weight = 20
+++

### Deploy Fargate Service 
In the following set of commands we are going to use CloudFormation to deploy services that will allow our Unicorn Store application to service traffic from the Internet. The CloudFormation template sets up an ECS Cluster, a Service, Task Definition, Task, and Application Load Balancer. 

```bash
cd ~/environment/modernization-devsecops-workshop/cfn
aws cloudformation create-stack --stack-name UnicornECS --template-body file://unicorn-store-ecs.yaml --capabilities CAPABILITY_NAMED_IAM

until [[ `aws cloudformation describe-stacks --stack-name "UnicornECS" --query "Stacks[0].[StackStatus]" --output text` == "CREATE_COMPLETE" ]]; do  echo "The stack is NOT in a state of CREATE_COMPLETE at `date`";   sleep 30; done && echo "The Stack is built at `date` - Please proceed"
```

{{% notice info %}}
This step takes approximately 3 minutes and if successfully, you should see the message as below.
{{% /notice %}}

<pre>
The stack is NOT in a state of CREATE_COMPLETE at Sun Aug  4 05:34:25 UTC 2019
The stack is NOT in a state of CREATE_COMPLETE at Sun Aug  4 05:34:55 UTC 2019
The stack is NOT in a state of CREATE_COMPLETE at Sun Aug  4 05:35:26 UTC 2019
The stack is NOT in a state of CREATE_COMPLETE at Sun Aug  4 05:35:57 UTC 2019
The stack is NOT in a state of CREATE_COMPLETE at Sun Aug  4 05:36:27 UTC 2019
The stack is NOT in a state of CREATE_COMPLETE at Sun Aug  4 05:36:58 UTC 2019
The Stack is built at Sun Aug  4 05:37:28 UTC 2019 - Please proceed
</pre>

To test, run the following query and copy the URL you obtain from the output into the address bar of a web browser.  You should see something similar to the image below.

```bash
aws elbv2 describe-load-balancers --names="UnicornStore-LB" --query="LoadBalancers[0].DNSName" --output=text
```

![Unicorn Store Image](/images/unicornstore.png)
