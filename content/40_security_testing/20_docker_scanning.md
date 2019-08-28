+++
title = "Docker Scanning"
chapter = false
weight = 20
+++

This stage you'll add linting of Dockerfiles to help you build best practice Docker images. For linting you'll be leveraging Hadolint, which is a popular open source project for linting Dockerfiles and validating inline bash. The linter parses the Dockerfile into an AST and performs rules on top of the AST. The rules aren't all security specific but they have good coverage across best practices.

To cause a build failure we are going to edit the Dockerfile and add a line that violates a hadolint check.  In the left hand pane of Cloud9, open up Dockerfile for editing.

We want to add the following to the end of the file `RUN cd /tmp && echo "hello!"` so your Dockerfile will look like this
```bash
FROM microsoft/dotnet:2.2-aspnetcore-runtime-alpine AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY UnicornStore/UnicornStore.csproj UnicornStore/
RUN dotnet restore UnicornStore/UnicornStore.csproj
COPY . .
WORKDIR /src/UnicornStore
RUN dotnet build UnicornStore.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish UnicornStore.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "UnicornStore.dll"]
HEALTHCHECK --interval=30s --timeout=5s --retries=5 --start-period=30s CMD wget --quiet --tries=1 --spider http://localhost/health || exit 1

RUN cd /tmp && echo "hello!"
```
Go ahead and save the file then run the following commands to push a new commit to the repo and kick off a pipeline build process

```bash
cd ~/environment/modernization-devsecops-workshop/
git add .
git commit -m "Updating Dockerfile"
git push origin master
```

This time your build will fail with an exit status of 1. Hadolint rules DL3003 and SC1035 are violated with the line `RUN cd /tmp && echo "hello!"`.  While still on the CodePipeline screen if you click on the **Details** button under Failed message it will take you to the build logs where you can review the failure. Click on it now and click **Link to execution details**

Near the bottom of the log the output will look similiar to this  
![Hadolint Failure](/images/hadolint-fail.png)

To fix this we need to open up the Dockerfile and remove the offending line.  Open up Dockerfile in Cloud9 and remove the line `RUN cd /tmp && echo "hello!"` and save the file.  The Dockerfile once edited should look like this.

```bash
FROM microsoft/dotnet:2.2-aspnetcore-runtime-alpine AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY UnicornStore/UnicornStore.csproj UnicornStore/
RUN dotnet restore UnicornStore/UnicornStore.csproj
COPY . .
WORKDIR /src/UnicornStore
RUN dotnet build UnicornStore.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish UnicornStore.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "UnicornStore.dll"]
HEALTHCHECK --interval=30s --timeout=5s --retries=5 --start-period=30s CMD wget --quiet --tries=1 --spider http://localhost/health || exit 1
```
Go ahead and add, commit, and push the changes to your repo
```bash
cd ~/environment/modernization-devsecops-workshop/
git add .
git commit -m "Updating Dockerfile"
git push origin master
```
If you head over to CodePipeline in the console and wait for the build you will notice this time the build process succeeds.  If you want to test if your Unicorn store is still functional, run the follow command in Cloud9's terminal and copy the URL to a browser.

```bash
aws elbv2 describe-load-balancers --names="UnicornStore-LB" --query="LoadBalancers[0].DNSName" --output=text
```

For more information about Hadolint <https://github.com/hadolint/hadolint>