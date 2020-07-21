#!/usr/bin/env sh
set -eou pipefail

# apk update

echo "--- network tools ---"
apk add --no-cache bind-tools netcat-openbsd curl

echo "--- general stuff ---"
apk add --no-cache git jq vim tmux zsh

echo "--- clients ---"
apk add --no-cache postgresql-client redis mongodb-tools

echo "--- dev libs ---"
apk add --no-cache git nodejs #go

# # decent prompt
echo "--- prompt setup zsh ---"

apk add --no-cache zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

curl -L https://github.com/tsenart/vegeta/releases/download/v12.8.3/vegeta-12.8.3-linux-amd64.tar.gz | tar -xz
mv vegeta /usr/local/bin

apk add --no-cache screenfetch --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

echo "screenfetch" >> ~/.zshrc
echo "export PATH=$HOME/go/bin:$PATH" >> ~/.zshrc


echo "--- cleanup ---"
rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*
