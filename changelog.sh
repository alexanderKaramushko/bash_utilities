#!/usr/bin/env bash

failed() { echo "Failed:" "$@" >&2 && exit 1; }

COMMIT_MESSAGE=$1
GIT_USER=$2
GIT_EMAIL=$3

[ -z "$COMMIT_MESSAGE" ] && failed "Pass COMMIT_MESSAGE for your updates"
[ -z "$GIT_USER" ] && failed "Pass GIT_USER that will be shown in history"
[ -z "$GIT_EMAIL" ] && failed "Pass GIT_EMAIL that will be shown in history"

# todo проверка не работает из-за использования спец. символов bash в коммите.
# [ ! "$CI_COMMIT_MESSAGE" =~ "/patch|minor|major\/[^\s']+/" ] && failed "Create valid branch name starting with patch/, minor/ or major/"

set_git_user() {
  git config --global user.name "${GIT_USER}"
  git config --global user.email "${GIT_EMAIL}"
}

set_git_repository() {
  git remote set-url origin "http://$CI_USER:$CI_PASSWORD@gitlab.path/$CI_PROJECT_PATH.git"
  git remote -v
}

get_version() {
  version=$(grep 'version' client/package.json | grep -o "[0-9]*\.[0-9]*\.[0-9]*")

  echo $version
}

create_changelog_message() {
  MR_id=$(git show $CI_COMMIT_SHA | grep -o '![0-9]*' | sed -e 's+!++g')
  update_date=$(date +%D)
  version=$(get_version)
  author=$(git show $CI_COMMIT_SHA --format="%an" --quiet)
  title=$(git show $CI_COMMIT_SHA --format="%s" --quiet)

  message="
    Author: $author\n
    Title: $title\n
    Date: $update_date\n
    Version: $version\n
    Changes: See http://gitlab.path/${CI_PROJECT_PATH}/-/merge_requests/${MR_id}\n
    ---"

  echo "${message}" | cat - client/CHANGELOG.md >client/temp && mv client/temp client/CHANGELOG.md
}

commit_and_push_changes() {
  version=$(get_version)

  git tag -a v$version -m "See http://gitlab.path/$CI_PROJECT_PATH/-/blob/$CI_COMMIT_REF_NAME/client/CHANGELOG.md for version description"
  git checkout -B "$CI_COMMIT_REF_NAME" "$CI_COMMIT_SHA"
  git commit -am "${COMMIT_MESSAGE}" && git push --no-verify --follow-tags origin $CI_COMMIT_REF_NAME
}

set_git_user
set_git_repository
create_changelog_message
commit_and_push_changes
