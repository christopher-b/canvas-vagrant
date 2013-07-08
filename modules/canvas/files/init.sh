#!/bin/sh
echo "Running init script"
apt-get update
apt-get install -qy python-software-properties python g++ make
apt-add-repository ppa:brightbox/ruby-ng
add-apt-repository ppa:chris-lea/node.js
apt-get update
touch ~/init_done
echo "Init script done"