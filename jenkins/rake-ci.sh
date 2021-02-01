#!/bin/bash

GIT_REPO=git@github.com:kingdonb/example-cdk8s-ruby.git
# GIT_REPO=https://github.com/kingdon-ci/example-cdk8s-ruby

# run cdk8s to hydrate yamls in dist/
pushd synths
npm install
npm run compile
cdk8s synth

# verbose
set -x

ssh-add ~/.ssh/id_ed25519_flux
git clone $GIT_REPO -b synths git-dist
cd git-dist

# prune (dist is only generating one file anyway)
mv -f ../dist/synths.k8s.yaml ./

# generate a new commit on synths branch and push
git add synths.k8s.yaml
git config --global user.email "kingdon-ci@nerdland.info"
git config --global user.name "kingdon-ci Robot (Jenkins)"
git commit -m"built synth.k8s from $GIT_COMMIT" synths.k8s.yaml
 sleep 6000
git push origin synths

# all done
popd
