
#!/bin/bash

# https://gist.github.com/robwierzbowski/5430952/
# Create and push to a new github repo from the command line.
# Grabs sensible defaults from the containing folder and `.gitconfig`.
# Refinements welcome.

# Gather constant vars
#CURRENTDIR=${PWD##*/}
#GITHUBUSER=$(git config github.user)

# Get user input
#read "REPONAME?New repo name (enter for ${PWD##*/}):"
#read "USER?Git Username (enter for ${GITHUBUSER}):"
#read "DESCRIPTION?Repo Description:"

echo "Starting deep repo replication..."
if [ $# -lt 2 ]
  then
    echo "Incorrect arguments supplied, please fix and retry"
fi

# cd into working directory
cd $WORKING_DIR

# Clone the old repo
git clone $2

# cd into the cloned repo
cd $1

# Curl json to the github API
curl -u ${GITHUBUSER} https://api.github.com/orgs/cablelabs/repos -d "{\"name\": \"${1}\", \"description\": \"\", \"private\": false, \"has_issues\": true, \"has_downloads\": true, \"has_wiki\": false}"

# Set the freshly created repo to the origin and push
# You'll need to have added your public key to your github account
git remote set-url origin git@github.com:cablelabs/${1}.git
git push --set-upstream origin master

#go back to project root
cd ..
