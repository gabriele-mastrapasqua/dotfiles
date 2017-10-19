# /bin/bash

echo "installing dev dependecies..."
sudo apt-get update && apt-get -y upgrade
sudo apt-get -y install aptitude nginx git python3-dev python3-pip silversearcher-ag vim emacs build-essentials htop glances 

# set git local account
git config --global user.email  "gabriele.mastrapasqua@gmail.com"
git config --global user.name  "gabrielem0"

echo "installing emacs config..."
cp -R emacs ~/.emacs.d

echo "installing minimal vimrc..."
cp .vimrc ~/.vimrc

