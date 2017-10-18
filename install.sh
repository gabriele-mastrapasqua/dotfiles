# /bin/bash

echo "installing dev dependecies..."
apt-get update && apt-get upgrade
apt-get -y install git python3-dev python3-pip silversearcher-ag vim emacs build-essentials htop glances 

# set git local account
git config --global user.email  "gabriele.mastrapasqua@gmail.com"
git config --global user.name  "gabrielem0"

echo "installing emacs config..."
cp -R emacs ~/.emacs.d

echo "installing minimal vimrc..."
cp .vimrc ~/.vimrc

