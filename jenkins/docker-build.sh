#!/bin/sh

if [[ -z "$DOCKER_REPO_USER" ]]; then
  echo "Must provide DOCKER_REPO_USER in environment" 1>&2
  exit 1
fi
if [[ -z "$DOCKER_REPO_PROJ" ]]; then
  echo "Must provide DOCKER_REPO_PROJ in environment" 1>&2
  exit 1
fi
if [[ -z "$DOCKER_REPO_HOST" ]]; then
  echo "Must provide DOCKER_REPO_HOST in environment" 1>&2
  exit 1
fi
if [[ -z "$GIT_COMMIT" ]]; then
  echo "Must provide GIT_COMMIT in environment" 1>&2
  exit 1
fi

GIT_COMMIT_SHORT=$(echo $GIT_COMMIT|cut -c1-8)

# docker login ${DOCKER_REPO_HOST} -u ${DOCKER_REPO_USER} -p ${DOCKER_REPO_PASSWORD}
docker build \
	-t ${DOCKER_REPO_HOST}/${DOCKER_REPO_USER}/${DOCKER_REPO_PROJ}:${GIT_COMMIT_SHORT} \
	--target prod .
docker build -t ${DOCKER_REPO_HOST}/${DOCKER_REPO_USER}/${DOCKER_REPO_PROJ}:bundler --target gem-bundle .
docker build -t ${DOCKER_REPO_HOST}/${DOCKER_REPO_USER}/${DOCKER_REPO_PROJ}:jenkins_${GIT_COMMIT_SHORT} --target jenkins .
