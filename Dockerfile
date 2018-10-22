# our base image
FROM ubuntu

ENV LANGUAGE = "en_AU:en"
ENV LC_ALL = (unset),
ENV LC_CTYPE = "UTF-8",
ENV LANG = "en_AU.UTF-8"

RUN locale-gen en_AU en_AU.UTF-8; dpkg-reconfigure locales

RUN apt-get update && apt-get install -y \
curl \
jq \
net-tools \
postgresql \
python3 \
python3-pip
