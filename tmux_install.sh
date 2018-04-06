#!/bin/bash -eu

TARGET_TMUX_VERSION=$(curl -sSfL https://api.github.com/repos/tmux/tmux/releases/latest | grep html_url | grep tmux |sed -e 's/.*tag\/\(.*\)".*/\1/g')

[[ -z ${TARGET_TMUX_VERSION} ]] && TARGET_TMUX_VERSION=$(git tag -l | grep -e '\([0-9]*\.[0-9]*\)' | sort -Vr | head -n1)

sudo apt-get update
sudo apt-get install -y libevent-dev libncurses5-dev
sudo apt-get install -y build-essential automake pkg-config

mkdir $HOME/tmp
mkdir -p $HOME/usr/local
cd $HOME/tmp
git clone https://github.com/tmux/tmux.git
cd tmux
git checkout ${TARGET_TMUX_VERSION}
./autogen.sh
./configure --prefix=$HOME/usr/local
make
make install

grep -F "/usr/local/bin" ~/.bash_profile || grep -F "/usr/local/bin" ~/.bashrc ||
echo "export PATH=\$HOME/usr/local/bin:\$PATH" >> ~/.bashrc
