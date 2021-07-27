set -e

echo "Starting release"

echo "Checking out develop branch"
git checkout develop
echo "Pull last changes"
git pull

echo "Start release with maven git flow plugin"
mvn gitflow:release-start
MVN_VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)
echo "Pushing release branch"
git push --set-upstream origin release/$MVN_VERSION


echo "Release branch was pushed with snapshot version. The deployment should have been trigerred on QA env."
echo "Once all the tests will be  ok then run finish-release.sh script."
exit 0
