#!/bin/bash
echo "Please enter release to be cleaned: "
read RELEASE_VERSION
echo "RELEASE_VERSION: $RELEASE_VERSION"

git branch -D merge/release-to-develop/$RELEASE_VERSION
git branch -D merge/release-to-master/$RELEASE_VERSION
git branch -D release/$RELEASE_VERSION


git push origin --delete merge/release-to-develop/$RELEASE_VERSION
git push origin --delete merge/release-to-master/$RELEASE_VERSION
git push origin --delete release/$RELEASE_VERSION
