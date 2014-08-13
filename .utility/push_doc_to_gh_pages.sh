#!/bin/bash

if [ "$TRAVIS_REPO_SLUG" == "macwadu/jira-rest" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_BRANCH" == "master" ]; then

  echo -e "Publishing documentation...\n"

  rake yard

  cp -R doc/ $HOME/doc-latest

  cd $HOME
  git config --global user.email ${GIT_NAME}
  git config --global user.name ${GIT_EMAIL}
  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/macwadu/jira-rest gh-pages > /dev/null

  cd gh-pages
  git rm -rf ./doc
  cp -Rf $HOME/doc-latest ./doc
  git add -f .
  git commit -m "Lastest doc on successful travis build $TRAVIS_BUILD_NUMBER auto-pushed to gh-pages"
  git push -fq https://${GITHUB_TOKEN}:x-oauth-basic@github.com/${TRAVIS_REPO_SLUG}.git gh-pages

  echo -e "Published doc to gh-pages.\n"
  
fi
