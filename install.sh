# /bin/bash

echo "installing dev dependecies..."
apt-get update && apt-get upgrade
apt-get -y install git python3-dev python3-pip silversearcher-ag vim emacs build-essentials htop glances 

echo "installing emacs config..."
cp -R emacs ~/.emacs.d

