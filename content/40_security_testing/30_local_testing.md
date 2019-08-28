+++
title = "Local Testing"
chapter = false
weight = 30
+++

Each of the different tests that we have instrumented in our pipeline so far can also be run on the developers local machine.  It is not uncommon in pratice to run tests on both the local development machine and within the pipeline.  The pipeline test is meant as a mechanism to fail a build stage that has not passed testing, while the local development environment test is meant to provide immediate feedback and diagnostic details to the developer.   

### TruffleHog
Let's go ahead and run the secret scans on our Cloud9 local development environment.

First we need to install TruffleHog
```bash
cd ~/environment/modernization-devsecops-workshop/
sudo pip install TruffleHog
```

Create a new file in the ~/environment/modernization-devsecops-workshop called secrets.txt, paste in the string below and save the file.
```bash
dbpassword=tSQ9jz7BqjXxNkYFvA0QNuMKtp8
```

Commit the change to git
```bash
git add .
git commit -m "Testing trufflehog"
```

Now run trufflehog to test the last commit for any secrets
```bash
trufflehog --regex --max_depth 1 .
```

You should get something similar to the output below
![TruffleHog Output](/images/trufflehog-local.png)

The green text states the reason, commit hash, and other interesting information.  The yellow text is the actual line that trufflehog found in the commit.  

{{% notice info %}}
For this workshop we are going to leave the file and commit, but on a real world development project we would run either *git revert* or *git reset* to remove the commit from our history.  
{{% /notice %}}

### Hadolint
This tool is very easy to run in our Cloud9 environment as it runs using Docker, which is already installed.

To run hadolint copy and paste the following into the Cloud9 terminal
```bash
cd ~/environment/modernization-devsecops-workshop/
docker run --rm -i hadolint/hadolint < Dockerfile
```

Nothing should have been found. So let's simulate an issue that hadolint will detect.  Open up the Dockerfile and add the following text to the bottom of the file and save.

```bash
RUN cd /tmp && echo "hello!"
```

Now run hadolint again

```bash
docker run --rm -i hadolint/hadolint < Dockerfile
```

This time you should see the following output
<pre>
/dev/stdin:22 DL3003 Use WORKDIR to switch to a directory
</pre>

If you look through the hadolint website <https://github.com/hadolint/hadolint> you will see that DL3003 is because of our usage of `cd` instead of the preferred WORKDIR.

### Testing 
We ran each of the commands manually, but normally you would want to add this as part of a unit testing suite. 

As an example, run the following command
```bash
cd ~/environment/modernization-devsecops-workshop/
./test_runner.sh
```

The output should look like the following
![Test Runner Shell Output](/images/test-runner.png)

Notice that both TruffleHog and Hadolint scanned for potential security issues and reported results.  An alternative to running security scans as part of a unit test script, scans can also be ran as part of **git hooks**.  Hooks are a way for git to run scripts before or after git events such as commit or push. TruffleHog could run right after a commit and hadolint could run pre commit.  This suggestion is made in an effort to reduce friction with developers.  Successful implementations of security in DevSecOps integrates with a developers normal workflow and does not require additional steps or processes that can easily be forgotten. And having security scans on developers local environments has the benefit of shortening the feedback loop.