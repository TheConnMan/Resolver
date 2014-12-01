#!/bin/bash

# Version Bumper

if [ "$#" -ne 2 ]; then
    echo "Two arguments required, version name and tag message respectively"
else
	echo -e "\nChecking out dev."
    git checkout dev
    
    echo -e "\nEditing injector."
    mv src/injector src/injector.temp
    sed "s/# Version .*/# Version $1/g" < src/injector.temp > src/injector
    rm src/injector.temp
    
    echo -e "\nCommitting updated version."
    git add src/injector
    git commit -m "Version bump to $1."
    
    git checkout master
    
    git merge --no-ff dev
    
    echo -e "\nTagging version $1."
    git tag -a v$1 -m "$2"
    
    git checkout dev
    
    echo -e "\nSUCCESS"
    echo "To push changes run 'push --all' and 'push --tags'."
fi
