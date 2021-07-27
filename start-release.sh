RELEASE=$1
DEVELOPMENT=$2
# exit as soon as there is an error
set -e

# check parameter
if [[ -z $RELEASE ||  -z $DEVELOPMENT]];
then
    echo `date`" - Missing mandatory arguments : versions. "
    echo `date`" - Usage: ./start-release.sh  [RELEASE] [DEVELOPMENT] . "
    exit 1
fi

echo "Starting release $RELEASE"

echo "Checking out develop branch"
git checkout develop
echo "Pull last changes"
git pull

echo "Start release with maven git flow plugin"
mvn gitflow:release-start -DreleaseVersion=$RELEASE -DdevelopmentVersion=$DEVELOPMENT

echo "Pushing release branch"
git push --set-upstream origin release/$RELEASE


echo "Release branch was pushed with snapshot version. The deployment should have been trigerred on QA env."
echo "Once all the tests will be  ok then run finish-release.sh script."
exit 0
