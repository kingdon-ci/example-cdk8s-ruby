#!/bin/bash

set -ex

apt-get update

apt-get install -y \
  netcat-openbsd \
  build-essential \
  libpq-dev \
  libyaml-dev \
  libreadline6-dev \
  zlib1g-dev \
  libssl-dev \
  libyaml-dev \
  libsqlite3-dev \
  sqlite3 \
  libgdbm-dev \
  libncurses5-dev \
  libffi-dev \
  imagemagick \
  wget
  # xvfb \
  # libqt5webkit5-dev \
  # qt5-default \
  # libxss1 \
  # libappindicator3-1 \
  # libindicator7 \
  # libgtk-3-0 \
  # fonts-liberation \
  # xdg-utils \
  # gconf-service \
  # libgconf-2-4 \
  # lsb-release \
  # libasound2 \
  # libnss3 \
  # libnspr4

# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# dpkg -i google-chrome-stable_current_amd64.deb

apt-get clean
rm -rf /var/lib/apt/lists/*
