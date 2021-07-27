set -e
echo "Finish release with maven git flow plugin"
mvn gitflow:release-finish

git checkout develop
git reset --soft origin/develop
git checkout -b merge/release-to-develop
git push

git checkout master
git reset --soft origin/develop
git checkout -b merge/release-to-develop
git push
