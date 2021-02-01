#!/bin/bash

GIT_REPO=git@github.com:kingdonb/example-cdk8s-ruby.git
# GIT_REPO=https://github.com/kingdon-ci/example-cdk8s-ruby

# run cdk8s to hydrate yamls in dist/
pushd synths
npm install

# run compile and test (fail the script and exit if test fails)
set -ex
npm run compile
npm run test
set +ex

# execute "synth" and make our synthetized yamls
cdk8s synth

# verbose
set -x

# add the SSH key mounted from secret, and clone git branch 'synths'
ssh-add ~/.ssh/id_ed25519_flux
git clone $GIT_REPO -b synths git-dist
cd git-dist

# prune (dist is only generating one file anyway)
mv -f ../dist/synths.k8s.yaml ./

# generate a new commit on synths branch and push
# FIXME: branches other than (whatever) should not result in a commit
git add synths.k8s.yaml
git config --global user.email "kingdon-ci@nerdland.info"
git config --global user.name "kingdon-ci Robot (Jenkins)"
git commit -m"built synth.k8s from $GIT_COMMIT" synths.k8s.yaml
git push origin synths

# all done
popd
