

# AWS DevSecOps Modernization Workshop

In this workshop, you will learn how to add security testing to a CI/CD pipeline of a dockerized .net (Unicorn Store) application using AWS CodeCommit, AWS CodeBuild, and AWS CodePipeline. The modules contained in this workshop will provide you with step-by-step instructions for committing, building, testing, and deploying software in an automation fashion. You will also learn about some basic security tests and where to instrument them in the software development lifecycle. 

## Generating the workshop static site pages with Hugo

### Install Hugo

macOS: `brew install hugo`

Windows: `choco install hugo -confirm`

Visit https://gohugo.io/getting-started/installing/ for detailed instructions.


### Clone this repo

`git clone https://github.com/jamesbland123/modernization-devsecops-workshop.git`

### Install node packages

`cd modernization-devsecops-workshop`

`npm install`

### Run Hugo locally

`npm run server`

### View site locally

Visit http://localhost:1313/ to see the site.