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
mv ../.git git-dist/
cd git-dist

# prune (dist is only generating one file anyway)
git checkout --track origin/synths
rm -rf *
mv ../dist/ .

# generate a new commit on synths branch and push
git commit -A -m"building from $GIT_COMMIT"
git push origin synths

# all done
popd
