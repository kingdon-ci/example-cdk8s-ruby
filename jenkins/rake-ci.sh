#!/bin/bash

source /etc/profile.d/rvm.sh
rvm ${RUBY}@testing

bundle check
bundle exec rake ci
