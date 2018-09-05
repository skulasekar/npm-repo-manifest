
#!/bin/bash

echo "Starting deep repo replication..."
if [ $# -lt 1 ]
  then
    echo "Incorrect arguments supplied, please fix and retry"
fi

# cd into working directory
cd $WORKING_DIR

sleep 1

# Curl json to the github API
curl -XDELETE -u ${GITHUBUSER}:${GITHUBPASSWORD} https://api.github.com/orgs/cablelabs/repos/$1
