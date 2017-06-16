#!/bin/bash -eu

sudo apt update
sudo apt install -y libevent-dev libncurses5-dev
sudo apt install -y build-essential automake pkg-config

mkdir $HOME/tmp
mkdir -p $HOME/usr/local
cd $HOME/tmp
git clone https://github.com/tmux/tmux.git
cd tmux
git checkout `git tag -l | sort -Vr | head -n1`
./autogen.sh
./configure --prefix=$HOME/usr/local
make
make install

grep -F "/usr/local/bin" ~/.bash_profile || grep -F "/usr/local/bin" ~/.bashrc ||
echo "export PATH=\$HOME/usr/local/bin:\$PATH" >> ~/.bashrc
