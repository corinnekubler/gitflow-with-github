set -e
echo "Finish release with maven git flow plugin"
mvn gitflow:release-finish



git checkout master
RELEASE_VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)

git reset --soft origin/master
git checkout -b merge/release-to-master/RELEASE_VERSION
git push --set-upstream origin merge/release-to-master


git checkout develop
git reset --soft origin/develop
git checkout -b merge/release-to-develop/RELEASE_VERSION
git push --set-upstream origin merge/release-to-develop
