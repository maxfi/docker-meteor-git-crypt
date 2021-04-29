#!/bin/bash -e

cd /root

export DEBIAN_FRONTEND=noninteractive

echo "================= Updating package lists ==================="
apt-get update

echo "================= Adding some global settings ==================="
mkdir -p $HOME/.ssh/
mv config $HOME/.ssh/

echo "================= Installing basic packages ==================="
apt-get install -y --no-install-recommends build-essential ca-certificates libssl-dev git curl python xxd

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