FROM ubuntu

ENV LANG en_AU.UTF-8
ENV LANGUAGE en_AU.UTF-8
ENV LC_ALL en_AU.UTF-8
ENV LC_CTYPE=en_AU.UTF-8
ENV TZ="Australia/Adelaide"
ENV DEBIAN_FRONTEND "noninteractive apt-get autoremove"

WORKDIR /tmp

RUN apt-get update \
    && apt-get install -y \
    locales && locale-gen en_AU.UTF-8 && dpkg-reconfigure locales

RUN apt-get update \
    && apt-get install -y \
    apt-utils \
    # # # net utils
    net-tools telnet dnsutils inetutils-traceroute iputils-ping netcat \
    git curl jq vim tmux \
    # # # state and db tools
    postgresql redis-tools mongodb-clients \
    # # # dev and edit tools
    nodejs npm \
    # # decent prompt
    zsh screenfetch \
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" | zsh || true \
    && echo "screenfetch" >> ~/.zshrc \
    && rm -rf /var/lib/apt/lists/*

COPY sleeper.sh /tmp

ENTRYPOINT ["sh", "/tmp/sleeper.sh"]

