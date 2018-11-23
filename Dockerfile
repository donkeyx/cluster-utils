# our base image
FROM ubuntu

ENV DEBIAN_FRONTEND "noninteractive apt-get autoremove"
RUN apt-get update && apt-get install -y locales \
    && locale-gen en_AU.UTF-8 \
    && dpkg-reconfigure locales \
    && rm -rf /var/lib/apt/lists/*
ENV LANG en_AU.UTF-8
ENV LANGUAGE en_AU.UTF-8
ENV LC_ALL en_AU.UTF-8
ENV LC_CTYPE=en_AU.UTF-8
ENV TZ="Australia/Adelaide"

# networking and routing tools
RUN apt-get update && apt install -y \
    net-tools telnet dnsutils inetutils-traceroute \
    curl jq

# client tools for db + redis/mongo
RUN apt-get update && apt install -y \
    postgresql redis-tools mongodb-clients \
    && rm -rf /var/lib/apt/lists/*

# node libs for test scripts
RUN apt-get update && apt-get install -y \
    git \
    nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# decent prompt
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

CMD ["zsh"]

