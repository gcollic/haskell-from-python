FROM ubuntu:19.04

# Fix docker build freeze https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image
ENV TZ=europe/paris
ENV DEBIAN_FRONTEND=noninteractive

# Update apt-get
RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y curl git wget vim \
        build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev \
        libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev \
        software-properties-common \
    && add-apt-repository -y ppa:hvr/ghc \
    && apt-get update \
    && apt-get install -y cabal-install-2.4 ghc-8.6.5 \
    && rm -rf /var/lib/apt/lists/* \
    && /opt/cabal/bin/cabal update

ENV PATH="/opt/cabal/bin/:/opt/ghc/bin/:${PATH}"

# Basic environment with some tools
RUN curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > /root/.bash_git
RUN echo "source /root/.bash_git" >> /root/.bashrc
RUN echo "GIT_PS1_SHOWDIRTYSTATE=1" >> /root/.bashrc
RUN echo "GIT_PS1_SHOWCOLORHINTS=1" >> /root/.bashrc
RUN echo "PS1='\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\$(__git_ps1 \" (%s)\") \\\$ '" >> /root/.bashrc

# Bat commandline (colored cat)
RUN cd ~ \
    && wget https://github.com/sharkdp/bat/releases/download/v0.11.0/bat_0.11.0_amd64.deb \
    && dpkg -i ./bat_0.11.0_amd64.deb

# Full Python environment
ENV PYTHON_MAJOR_VERSION=3
ENV PYTHON_MINOR_VERSION=3.7
ENV PYTHON_FULL_VERSION=3.7.4
RUN wget https://www.python.org/ftp/python/${PYTHON_FULL_VERSION}/Python-${PYTHON_FULL_VERSION}.tgz \
    && tar xzf Python-${PYTHON_FULL_VERSION}.tgz \
    && cd Python-${PYTHON_FULL_VERSION} && ./configure --enable-optimizations && make install \
    && cd /usr/local/bin && ln -s python${PYTHON_MINOR_VERSION} python
# RUN curl https://bootstrap.pypa.io/get-pip.py | python

COPY . /sources
WORKDIR /sources
