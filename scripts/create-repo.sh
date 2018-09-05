
#!/bin/bash

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

sleep 1

# Curl json to the github API
curl -u ${GITHUBUSER}:${GITHUBPASSWORD} https://api.github.com/orgs/cablelabs/repos -d "{\"name\": \"${1}\", \"description\": \"\", \"private\": false, \"has_issues\": true, \"has_downloads\": true, \"has_wiki\": false}"

# Set the freshly created repo to the origin and push
git remote set-url origin git@github.com:cablelabs/${1}.git
git push --set-upstream origin master

#go back to project root
cd ..
