set -e
echo "Finish release with maven git flow plugin"
mvn gitflow:release-finish



git checkout master
git pull
RELEASE_VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)
git reset --soft origin/master
git checkout -b merge/release-to-master/$RELEASE_VERSION
git commit -m "Changes for release $RELEASE_VERSION"
git push --set-upstream origin merge/release-to-master/$RELEASE_VERSION


git checkout develop
git pull
git reset --soft origin/develop
git checkout -b merge/release-to-develop/$RELEASE_VERSION
git commit -m "Changes for release $RELEASE_VERSION"
git push --set-upstream origin merge/release-to-develop/$RELEASE_VERSION
