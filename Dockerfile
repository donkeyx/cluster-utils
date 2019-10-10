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


# client tools for db + redis/mongo
RUN apt-get update && apt-get install -y \
    # net utils
    net-tools telnet dnsutils inetutils-traceroute iputils-ping netcat \
    curl jq \
    # state and db tools
    postgresql redis-tools mongodb-clients \
    # dev and edit tools
    git \
    nodejs npm \
    vim \
    tmux \
    && rm -rf /var/lib/apt/lists/*

# decent prompt
RUN apt-get update && apt-get install -y \
    zsh screenfetch \
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" | zsh || true \
    && echo "screenfetch" >> ~/.zshrc \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["zsh"]

