+++
title = "Creating your environment"
chapter = false
weight = 1
+++

{{% notice warning %}}
You are responsible for the cost of the AWS services used while running this workshop in your AWS account.
{{% /notice %}}

In order for you to succeed in this workshop, you will need to run through a few steps in order to properly setup and configure your environment. These steps will include provisioning some services, installing some tools, and downloading some dependencies as well. We will begin with [AWS Cloud9](https://aws.amazon.com/cloud9/). Technically, you should be able to complete many of the steps in these modules if you have a properly configured terminal. However, in order to avoid the *"works on my machine"* response you've surely experienced at some point in your career, I strongly encourage you to proceed with launching Cloud9.

{{% notice tip %}}
[AWS Cloud9](https://aws.amazon.com/cloud9/) is a cloud-based integrated development environment (IDE) that lets you write, run, and debug your code with just a browser. It includes a code editor, debugger, and terminal. Cloud9 comes prepackaged with essential tools for popular programming languages, including JavaScript, Python, PHP, and more, so you don’t need to install files or configure your development machine to start new projects.
{{% /notice %}}

### Deploy & Launch AWS Cloud9

   [Click here to deploy using CloudFormation template](https://console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/new?stackName=UnicornDevSecOpsWorkshop&templateURL=https://modernization-workshop-west-2.s3-us-west-2.amazonaws.com/devops/cfn/modernization-workshop.yaml)

   - Create stack click, **Next**
   - Specify stack details, click **Next**
   - Configure stack options, click **Next**
   - Review UnicornDevSecOpsWorkshop, scroll to bottom section under **Capabilities** and check both boxes and click **Create stack** 

>The deployment process takes approximately 2-3 minutes to complete. In the meantime, you can review the [deployment guide](https://aws-quickstart.s3.amazonaws.com/quickstart-cloud9-ide/doc/aws-cloud9-cloud-based-ide.pdf) while you wait.

Once the installation is complete, go to Cloud9 within the console and click on **Open IDE** on the name that begins with WorkshopIDE.

### Clone the source repository for this workshop

Now we want to clone the repository that contains all the content and files you need to complete this workshop.

```bash
cd ~/environment && \
git clone https://github.com/jamesbland123/modernization-devsecops-workshop.git
```

### Increase AWS Cloud9 disk/storage
```bash
cd ~/environment/modernization-devsecops-workshop/scripts
./resize.sh 50
```

### Update and install some tools

This step updates and installs various tools needed to complete the workshop.  Feel free to look at the script if you are curious about what gets updated and installed.  

```bash
./getting_started.sh
```
Next, lets source .bashrc to add .net PATH to our current working environment

```bash
. ~/.bashrc
```

{{% notice info %}}
The last few lines of the output will look similar to the below window
{{% /notice %}}

<pre>
Deleted: sha256:84e9cc454dd9325a12774267998ebb5adca00dd5907c73b447fd3437611209d0
Deleted: sha256:c8462350bd81d6d8264a9e682949efe0c650f1a3a6800ceccf335e70bbcdf1f9
Deleted: sha256:0c5fd0b1e438aa8d08d6ca8e0bcf1121e897987d1b24495467cb18b1d9104e19
Deleted: sha256:88e3926a38f1a1d6e57eadbfc2cbcc27f46d954b58e9dfc902e05879cd8f99b9
xxxyyy_user:~/environment/modernization-devsecops-workshop/scripts (master) $ . ~/.bashrc
function
xxxyyy_user:~/environment/modernization-devsecops-workshop/scripts (master) $ 
</pre>



