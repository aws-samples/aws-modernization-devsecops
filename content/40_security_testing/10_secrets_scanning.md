+++
title = "Secrets Scanning"
chapter = false
weight = 10
+++

In this stage you are going to test for secrets accidentally saved in your repository.  For this stage you'll be leveraging trufflehog, a popular open source project for finding secrets accidentally committed in repositories. It essentially searches through git repositories for secrets, digging deep into commit history and branches. It identifies secrets by running entropy checks as well as high signal regex checks. 

To get started, lets open up buildspec.yml in the left hand pane of Cloud9.

We want to change the line that has 
<pre>
- trufflehog --regex --max_depth 1 $APP_SOURCE_REPO_URL
</pre>

to this
```bash
- trufflehog --regex --max_depth 1000 $APP_SOURCE_REPO_URL
```
> Notice we changed 1 to 1000

Now save the file and run the following to push changes to our CodeCommit repository and go to CodePipeline in the console to watch our CI/CD process.

```bash
cd ~/environment/modernization-devsecops-workshop/
git add .
git commit -m "Updating trufflehog max_depth value"
git push origin master
```

Once CodePipeline detects a change to your repo it will start a new process.  This time the build will fail.  The Unicorn Store test repo has secrets in it's commit history, so the build will exit out with a status of 1, causing the build to fail.  While still on the Pipeline screen if you click on the **Details** button under Failed message it will take you to the build logs where you can review the failure. Click on it now and click **Link to execution details**

Near the bottom of the log the output will look similiar to this
![Truffle Hog Secret Found](/images/trufflehog-fail.png)

Let's change the buildspec.yml again so that our build passes. You typically want to set this value to a low number during your CI/CD process so only the latest commits are scanned. If you are running trufflehog offline on your local machine you may want to scan the entire commit history as you don't want to leak secrets into your repo.  We will set this back to a value of 1 so only the current commit is scanned for secrets. 

We want to change the line that has 
<pre>
- trufflehog --regex --max_depth 1000 $APP_SOURCE_REPO_URL
</pre>

back to this
```bash
- trufflehog --regex --max_depth 1 $APP_SOURCE_REPO_URL
```

Now save the file and run the following to push changes to our CodeCommit repository and go to CodePipeline in the console to watch our CI/CD process.

```bash
cd ~/environment/modernization-devsecops-workshop/
git add .
git commit -m "Updating trufflehog max_depth value"
git push origin master
```

If you watch CodePipeline now the CI/CD process should now succeed. 

For more information about truffleHog <https://github.com/dxa4481/truffleHog>



