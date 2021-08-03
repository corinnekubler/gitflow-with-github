#Release process
The script uses mvn gitflow but with some manual processes as it is not wanted to push directly on master and on develop. We prefer to use PR.

## Starting a release
Make  sure you have your develop branch is up to date with no remaining changes  and launch the script `start-release.sh` you will be prompt for a release version
This script will create and push to origin Branch 'release/<release-version>' and update the pom version of all the modules on this branch  to <release-version>-SNAPSHOT

## Finishing a release
Once all the tests have been done on QA and all the bugs fixed launc script `finish-release.sh"`.
If some conflicts are present, resolve them then `git commit` and relaunch the script.

This script will create 2 branches for the modifications to be merged on develop and master branch:
- merge/release-to-develop/$RELEASE_VERSION
- merge/release-to-master/$RELEASE_VERSION

Once the script is finished you can create 2 PR:
- 1 for master from branch merge/release-to-master/$RELEASE_VERSION
- 1 for develop from branch merge/release-to-develop/$RELEASE_VERSION

Then the PR will be approved and merged.

At the end:
 - the release changes are merged in master and develop branches:
 - the POM versions are set to $RELEASE_VERSION in master branch.
 - the POM versions are set to ($RELEASE_VERSION+1)-SNAPSHOT in develop branch.

## Cleaning a release
If everything is ok then we can launch the `clean-release.sh`
This script will remove all the branches created for the release (local and remote)

