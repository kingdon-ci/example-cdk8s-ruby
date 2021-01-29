#!/bin/bash

source /etc/profile.d/rvm.sh
set -euo pipefail

# Install any desirable packages here
apt-get update && apt-get install -y --no-install-recommends \
  manpages vim \
  build-essential rsync \
  tzdata cmake pkg-config

# # Upgrade, install nodejs, yarn (in the RVM context)
apt-get upgrade -y --no-install-recommends
## nodejs, yarn are both provided by the ruby3 support upstream:
## docker-rvm-support/Dockerfile.ruby3
# curl -sL https://deb.nodesource.com/setup_14.x | bash -
# curl -o- -L https://yarnpkg.com/install.sh | bash

# Clean up
apt-get clean
rm -rf /var/lib/apt/lists/*
