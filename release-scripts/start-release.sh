#!/bin/bash
set -e

echo "Starting release"

echo "Checking out develop branch"
git checkout develop
echo "Pulling last changes"
git pull

echo "Starting release with maven git flow plugin"
mvn gitflow:release-start
MVN_VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)
RELEASE_VERSION=${MVN_VERSION//"-SNAPSHOT"/""}
echo "RELEASE $RELEASE_VERSION"
echo "Pushing release branch"
git push --set-upstream origin release/$RELEASE_VERSION
echo "To finish up the release process, run finish-release.sh"
exit 0
