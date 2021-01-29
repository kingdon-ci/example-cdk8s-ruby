#!/bin/sh

WORKING_SUFFIX=$(if git status --porcelain | grep -qE '^(?:[^?][^ ]|[^ ][^?])\s'; then echo "-WIP"; else echo ""; fi)
CURRENT_TAG=$(if TAG=$(git describe --tags --exact-match 2>/dev/null); then echo $TAG; else echo ""; fi)
if test -z "$WORKING_SUFFIX" && test ! -z "$CURRENT_TAG"
then
   echo $CURRENT_TAG
else
   BRANCH_PREFIX=$(git rev-parse --abbrev-ref HEAD)

   # Fix the object name prefix length to 8 characters to have it consistent across the system.
   # See https://git-scm.com/docs/git-rev-parse#Documentation/git-rev-parse.txt---shortlength
   echo "${BRANCH_PREFIX//\//-}-$(git rev-parse --short=8 HEAD)$WORKING_SUFFIX"
fi
