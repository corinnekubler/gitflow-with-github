VERSION=$1
# exit as soon as there is an error
set -e

# check parameter
if [[ -z $VERSION ]];
then
    echo `date`" - Missing mandatory argument : version. "
    echo `date`" - Usage: ./start-release.sh  [version]. "
    exit 1
fi

echo "Starting release with version echo $VERSION"


echo "Checking out develop branch"
git checkout develop
echo "Pull last changes"
git pull

echo "Start release with maven git flow plugin for version $VERSION"
mvn gitflow:release-start -DversionProperty $VERSION

echo "Pushing release branch"
git push

echo "Release branch was pushed with snapshot version. The deployment should have been trigerred on QA env."
echo "Once all the tests will be  ok then run finish-release.sh script."
exit 0
