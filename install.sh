#!/bin/bash -e

cd /root

echo "================= Adding some global settings ==================="
mkdir -p $HOME/.ssh/
mv config $HOME/.ssh/

echo "================= Installing packages ==================="
# https://stackoverflow.com/questions/8671308/non-interactive-method-for-dpkg-reconfigure-tzdata/51881727#51881727
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true 
echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections;
echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections;
apt-get update && apt-get install -y --no-install-recommends \
software-properties-common \
build-essential \
ca-certificates \
libssl-dev \
openssh-client \
git \
curl \
xxd

echo "================= Installing git-crypt ==================="
git clone https://github.com/AGWA/git-crypt.git /tmp/git-crypt
(cd /tmp/git-crypt && make && make install)

echo "================= Installing Meteor ==================="
curl https://install.meteor.com/ | sh

echo "================= Cleaning package lists ==================="
apt-get clean -y
apt-get autoclean -y
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*