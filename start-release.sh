RELEASE-VERSION=$1
DEVELOPMENT-VERSION=$1
# exit as soon as there is an error
set -e

# check parameter
if [[ -z $RELEASE-VERSION |  -z $DEVELOPMENT-VERSION]];
then
    echo `date`" - Missing mandatory arguments : versions. "
    echo `date`" - Usage: ./start-release.sh  [RELEASE-VERSION] [DEVELOPMENT-VERSION] . "
    exit 1
fi

echo "Starting release $RELEASE-VERSION"

echo "Checking out develop branch"
git checkout develop
echo "Pull last changes"
git pull

echo "Start release with maven git flow plugin"
mvn gitflow:release-start -DreleaseVersion=$RELEASE-VERSION -DdevelopmentVersion=$DEVELOPMENT-VERSION

echo "Pushing release branch"
git push --set-upstream origin release/1.10


echo "Release branch was pushed with snapshot version. The deployment should have been trigerred on QA env."
echo "Once all the tests will be  ok then run finish-release.sh script."
exit 0
