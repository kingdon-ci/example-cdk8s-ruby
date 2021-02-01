#!/bin/bash

source /etc/profile.d/rvm.sh
rvm ${RUBY}@testing

bundle check
bundle exec rake ci

# run cdk8s to hydrate yamls in dist/
pushd synths
cdk8s synth

# strict bash
set -euo pipefail
# verbose
set -x

# harvest .git for use with synths/dist content
mkdir git-dist
rsync -a --delete ../.git/ git-dist/.git
cd git-dist

# prune (dist is only generating one file anyway)
git fetch
git checkout --track origin/synths
mv -f ../dist/synths.k8s.yaml ./

# generate a new commit on synths branch and push
git commit -m"built synth.k8s from $GIT_COMMIT" synths.k8s.yaml
git push origin synths

# all done
popd
