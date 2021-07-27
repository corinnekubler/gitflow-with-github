echo "Starting release "

echo "Checking out develop branch"
git checkout develop
echo "Pull last changes"
git pull

echo "Start release with maven git flow plugin"
mvn gitflow:release-start

echo "Pushing release branch"
git push

echo "Release branch was pushed with snapshot version. The deployment should have been trigerred on QA env."
echo "Once all the tests will be  ok then run finish-release.sh script."
exit 0
