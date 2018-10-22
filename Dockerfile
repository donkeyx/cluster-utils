# our base image
FROM ubuntu

# RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TZ="Australia/Adelaide"

#ENV LANGUAGE = "en_AU:en"
#ENV LC_ALL = (unset),
#ENV LC_CTYPE = "UTF-8",
#ENV LANG = "en_AU.UTF-8"


# ENV TZ="Australia/Adelaide"

RUN apt update && apt install -y \
    locales \
    && locale-gen en_AU.UTF-8; dpkg-reconfigure locales \
    && rm -rf /var/lib/apt/lists/*

RUN apt update && apt install -y \
    net-tools telnet dnsutils \
    curl jq \
    postgresql redis-tools mongodb-clients \
    && rm -rf /var/lib/apt/lists/*
