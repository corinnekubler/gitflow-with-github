#!/bin/bash
set -e
echo "Finish release with maven git flow plugin"
git checkout develop
echo "Pulling develop branch"
git pull
git checkout master
echo "Pulling master branch"
git pull

mvn gitflow:release-finish


echo "Checking out master branch"
git checkout master
echo "Pulling master branch"
git pull
RELEASE_VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)
git reset --soft origin/master
echo "Creating a branch for PR to merge changes to master branch"
git checkout -b merge/release-to-master/$RELEASE_VERSION
git commit -m "release: changes for release $RELEASE_VERSION"
echo "Pushing the branch merge/release-to-master/$RELEASE_VERSION"
git push --set-upstream origin merge/release-to-master/$RELEASE_VERSION

echo "Checking out develop branch"
git checkout develop
echo "Pulling develop branch"
git pull
git reset --soft origin/develop
echo "Creating a branch for PR to merge changes to develop branch"
git checkout -b merge/release-to-develop/$RELEASE_VERSION
git commit -m "release: changes for release $RELEASE_VERSION"
echo "Pushing the branch merge/release-to-develop/$RELEASE_VERSION"
git push --set-upstream origin merge/release-to-develop/$RELEASE_VERSION

echo "Pushing Tag for release"
git push origin $RELEASE_VERSION

echo "Deleting temporaty branches for release"
git branch -D merge/release-to-develop/$RELEASE_VERSION

git branch -D merge/release-to-master/$RELEASE_VERSION

git branch -D release/$RELEASE_VERSION

echo "If everything is ok then run clean-release.sh"
