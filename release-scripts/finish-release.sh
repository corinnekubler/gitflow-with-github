#!/bin/bash
push-release-changes-on-new-branch()
{
  BRANCH=$1
  RELEASE_VERSION=$2
  git checkout -b $BRANCH
  git commit -m 'release: changes for release $RELEASE_VERSION'"
  echo "Pushing the branch $BRANCH"
  git push --set-upstream $BRANCH
}


set -e
echo "Finish release with maven git flow plugin"
echo "Checking out master branch"
git checkout master
echo "Pulling master branch"
git pull
echo "Checking out master branch"
git checkout develop
echo "Pulling master branch"
git pull


cd "$(dirname "$BASH_SOURCE")"/..
mvn gitflow:release-finish


echo "Checking out master branch"
git checkout master
echo "Pulling master branch"
git pull
RELEASE_VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)
git reset --soft origin/master
echo "Creating a branch for PR to merge changes to master branch"
push-release-changes-on-new-branch merge/release-to-master/$RELEASE_VERSION $RELEASE_VERSION

echo "Checking out develop branch"
git checkout develop
echo "Pulling develop branch"
git pull
git reset --soft origin/develop
echo "Creating a branch for PR to merge changes to develop branch"
push-release-changes-on-new-branch merge/release-to-develop/$RELEASE_VERSION $RELEASE_VERSION

echo "Pushing Tag for release"
git push origin $RELEASE_VERSION

echo "If everything is ok then run clean-release.sh"
