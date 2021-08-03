#Release process

## Starting a release
Make  sure you have your develop branch is up to date with no remaining changes  and launch the script `start-release.sh` you will be prompt for a release version
This script will create and push to origin Branch 'release/<release-version>' and update the pom version of all the modules on this branch  to <release-version>-SNAPSHOT

## Finishing a release
Once all the tests have been done on QA and all the bugs fixed launc script `finish-release.sh"`.
If some conflicts are present, resolve them then `git commit` and relaunch the script.

This script will create 2 branches for the modifications to be merged on develop and master branch:
- merge/release-to-develop/$RELEASE_VERSION
- merge/release-to-master/$RELEASE_VERSION

Once the script is finished

