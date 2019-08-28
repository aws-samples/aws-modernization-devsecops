---
title: "AWS Modernization DevSecOps Workshop"
chapter: true
weight: 1
---

# AWS Modernization DevSecOps Workshop

### Welcome

<p style='text-align: left;'>
    In this workshop, you will learn how to add security testing to a CI/CD pipeline of a dockerized .net (Unicorn Store) application using AWS CodeCommit, AWS CodeBuild, and AWS CodePipeline. The modules contained in this workshop will provide you with step-by-step instructions for committing, building, testing, and deploying software in an automation fashion. You will also learn about some basic security tests and where to instrument them in the software development lifecycle. 
</p>

### Objectives
- Gain familiarity with the workflow of a modern application
- Learn where to add security testing to a CI/CD pipeline
- Learn about AWS services used to orchestrate testing 

### What we will cover in this workshop
- Setup of a Cloud9 environment
- Usage of AWS CloudFormation to automate the deployment of infrastructure
- Deployment of Amazon Elastic Container Service
- Deploy and use a modenized pipeline using AWS CodePipeline, CodeCommit, and CodeBuild 
- Instrument a couple of security testing/scanning tools

### Sample reference architecture

<p style='text-align: left;'>
    At the conclusion of this workshop, you will end up with various AWS services provisioned in your AWS account. The following diagram illustrates some of these services and is intended as a sample reference architecture.
</p>

![Reference Architecture](/images/aws-pipeline.png)

### Workshop flow

<p style='text-align: left;'>
    Each section or module contained in this workshop is designed to guide you through each step of the process to build the architecture referenced above. This is accomplished by using AWS Cloud 9 as our starting point along with a `git clone` of the content from our repository. Everything you need is provided to you including sample code, AWS CloudFormation templates, and detailed instructions. We will be using the AWS CLI from our Cloud9 instance to deploy the CloudFormation templates and build out our environment. 
</p>


{{% notice warning %}}
<p style='text-align: left;'>
The examples and sample code provided in this workshop are intended to be consumed as instructional content. These will help you understand how various AWS services can be architected to build a solution while demonstrating best practices along the way. These examples are not intended for use in production environments.
</p>
{{% /notice %}}