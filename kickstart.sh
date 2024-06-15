#!/usr/bin/env sh
set -eu pipefail

# # decent prompt
echo "--- prompt setup zsh ---"

sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

curl -sS -L https://github.com/tsenart/vegeta/releases/download/v12.8.3/vegeta-12.8.3-linux-amd64.tar.gz | tar -xz
mv vegeta /usr/local/bin

# Create a new script that runs screenfetch and then prints the additional information
cat <<EOF > ~/customfetch
#!/usr/bin/env sh
screenfetch
cat <<INFO
This container is useful for cluster and network testing with many tools.

database connection tools:
- psql, redis-cli, mongo
network testing tools:
- curl, wget, ping, traceroute, mtr, nmap, tcpdump, netcat
performance testing tools:
- vegeta, k6
programming languages:
- golang, python, nodejs
shell:
- zsh with oh-my-zsh

INFO
EOF

chmod +x ~/customfetch

# Add customfetch to .zshrc so it runs whenever a new shell starts
echo "~/customfetch" >> ~/.zshrc
echo "export PATH=$HOME/go/bin:$PATH" >> ~/.zshrc

echo "--- cleanup ---"
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*