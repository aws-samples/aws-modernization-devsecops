+++
title = "Test Pipeline"
chapter = false
weight = 5
+++

### AWS CodePipeline Workflow

A pipeline models our workflow from end to end. Within our pipeline we can have stages, and you can think of stages as groups of actions. An action or a plug-in is what acts upon the current revision that is moving through your pipeline. This is where the actual work happens in your pipeline. Stages can then be connected by transitions and in our console we represent these by an arrow between each stage. Our pipeline will consist of *three* stages:

![CICD](/images/pipeline-view2.png)

The *Source* stage monitors for changes to our source code repository. When a change is made, we will transition to the following stage. In this case, our *Build* stage. Here we will use CodeBuild to run various tests within our pipeline. The process will check for various security issues and fail the build if any are found. These various phases are defined within our *BuildSpec* which will be found in the *buildspec.yml* in the source code directory. A sample of this file is below:

<pre>
version: 0.2
phases:
  install:
    runtime-versions:
      docker: 18
  pre_build:
    commands:
      - $(aws ecr get-login --region $AWS_DEFAULT_REGION --no-include-email)
      - COMMIT_HASH=$(echo $CODEBUILD_RESOLVED_SOURCE_VERSION | cut -c 1-7)
      - IMAGE_TAG=${COMMIT_HASH:=latest}
      - echo Setting CodeCommit Credentials
      - git config --global credential.helper '!aws codecommit credential-helper $@'
      - git config --global credential.UseHttpPath true
      - echo Installing TruffleHog
      - pip install TruffleHog
  build:
    commands:
      - echo Running TruffleHog Secrets Scan
      - trufflehog --regex --max_depth 1 $APP_SOURCE_REPO_URL
      - echo Scanning with Hadolint
      - docker run --rm -i hadolint/hadolint < Dockerfile
      - echo Build started on `date`
      - echo Building the Docker image...
      - docker build -t $REPOSITORY_URI:latest .
      - docker tag $REPOSITORY_URI:latest $REPOSITORY_URI:$IMAGE_TAG
  post_build:
    commands:
      - echo Build completed on `date`
      - echo Pushing the Docker images...
      - docker push $REPOSITORY_URI:latest
      - docker push $REPOSITORY_URI:$IMAGE_TAG
      - echo Writing image definitions file...
      - printf '[{"name":"modernization-unicorn-store_unicornstore","imageUri":"%s"}]' $REPOSITORY_URI:$IMAGE_TAG > imagedefinitions.json
artifacts:
  files: imagedefinitions.json
</pre>

Our particular tests will be part of the build stage in the *buildspec.yml* file.  The tests will run prior to building the Docker image.  This particular point within the build stage is chosen as it allows feedback at the earliest point within the CI/CD pipeline for the type of test that is instrumented. Once the security testing is complete and successful, our build stage starts our Docker image build.  When the new Docker image has been successfully built and stored in ECR, we transition to our final stage where we deploy the image to our AWS Fargate cluster. During the *Deploy* stage, we will then consume the **imagedefinitions.json** output from the *post_build* process to sping up a new container using our newly created image into our existing cluster.

{{% notice info %}}
It is not covered in this workshop, but additional testing such as penetration test and other black box testing methods can be instrumented in the *post_build* phase within the *buildspec.yml*.  The *post_build* phase is where you would place any testing and instructions that are completed after a Docker image has been built.  
{{% /notice %}}
