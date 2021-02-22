#!/bin/bash

# run cdk8s to hydrate yamls in dist/ (... first, setup)
pushd synths
npm install

# run compile and test (set -ex to fail the job if compile or test fails)
set -ex
npm run compile
npm run test
set +ex

# execute "synth" and make our synthetized yamls in the dist/ directory
echo '+ cdk8s synth'
cdk8s synth

# done with nodejs, turn on verbose mode again
set -x

# fetch git branch 'synths' and run `git checkout synths`
/usr/bin/git -c protocol.version=2 fetch \
	--no-tags --prune --progress --no-recurse-submodules \
	--depth=1 origin synths
git checkout synths --

# put the generated yaml where `git add` can find it
mv -f dist/synths.k8s.yaml ../
git diff

# all done (commit will take place in next action)
popd
