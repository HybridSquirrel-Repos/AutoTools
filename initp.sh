#!/bin/bash


# Group IDs
PUBLIC=""
PRIVATE=""
LAB=""


# Tokens/Username
USER=""
GITLAB=""
GITHUB=""


# Logic
if [[ "$1" == "prv" ]]
then

    echo "Creating Project..."

    curl -s -S -o /dev/null --fail --header "PRIVATE-TOKEN:$GITLAB" -X POST "https://gitlab.com/api/v4/projects?name=$2&visibility=private&namespace_id=$PRIVATE"

    git clone <URL> # $2 is project name. URL needs to ends with $2.git

elif [[ "$1" == "lab" ]]
then

    echo "Creating Project..."

    curl -s -S -o /dev/null --fail --header "PRIVATE-TOKEN:$GITLAB" -X POST "https://gitlab.com/api/v4/projects?name=$2&visibility=private&namespace_id=$LAB"

    git clone <URL> # $2 is project name. URL needs to ends with $2.git

elif [[ "$1" == "pub" ]]
then

        echo "Creating Project..."

        ID=$(curl -s -S --fail --header "PRIVATE-TOKEN:$GITLAB" -X POST "https://gitlab.com/api/v4/projects?name=$2&visibility=public&namespace_id=$PUBLIC" | jq -r '.id')

        curl -s -S -o /dev/null --fail -u $USER:$GITHUB -H "Accept:application/vnd.github.v3+json" -X POST "https://api.github.com/orgs/HybridSquirrel-Repos/repos" -d '{"name":"'$2'"}'

        curl -s -S -o /dev/null --fail -X POST --data "url=https://$GITHUB@github.com/HybridSquirrel-Repos/$2.git&enabled=true" --header "PRIVATE-TOKEN:$GITLAB" "https://gitlab.com/api/v4/projects/$ID/remote_mirrors"

        git clone <URL> # $2 is project name. URL needs to ends with $2.git
else

    # Error msg
    echo "Needs exprestion"

fi
