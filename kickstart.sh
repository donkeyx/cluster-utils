#!/usr/bin/env sh
set -eou pipefail

# # decent prompt
echo "--- prompt setup zsh ---"

apk add --no-cache zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

curl -sS -L https://github.com/tsenart/vegeta/releases/download/v12.8.3/vegeta-12.8.3-linux-amd64.tar.gz | tar -xz
mv vegeta /usr/local/bin

# apk add --no-cache screenfetch --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

# echo "screenfetch" >> ~/.zshrc
# echo "export PATH=$HOME/go/bin:$PATH" >> ~/.zshrc


echo "--- cleanup ---"
rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*
