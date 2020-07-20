#!/usr/bin/env bash
# set -eou pipefail

apt-get update

# echo "--- network tools ---"
apt-get install -y apt-utils net-tools telnet dnsutils inetutils-traceroute iputils-ping netcat curl wget

# echo "--- general stuff ---"
apt-get install -y git jq vim tmux zsh

# echo "--- clients ---"
apt-get install -y postgresql redis-tools mongo-tools

echo "--- dev libs ---"
apt-get install -y git nodejs npm golang


# # decent prompt
echo "--- prompt setup zsh ---"
apt-get install -y screenfetch zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "screenfetch" >> ~/.zshrc
echo "export PATH=$HOME/go/bin:$PATH" >> ~/.zshrc

go get github.com/tsenart/vegeta

echo "--- cleanup ---"
rm -rf /var/lib/apt/lists/*
