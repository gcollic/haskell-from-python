FROM ubuntu:16.04

# Update apt-get
RUN apt-get update && apt-get dist-upgrade -y

# Basic environment with some tools
RUN apt-get install -y curl git wget vim
RUN curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > /root/.bash_git
RUN echo "source /root/.bash_git" >> /root/.bashrc
RUN echo "GIT_PS1_SHOWDIRTYSTATE=1" >> /root/.bashrc
RUN echo "GIT_PS1_SHOWCOLORHINTS=1" >> /root/.bashrc
RUN echo "PS1='\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\$(__git_ps1 \" (%s)\") \\\$ '" >> /root/.bashrc

# Full Python environment
RUN apt-get install -y build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev \
    libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev
ENV PYTHON_MAJOR_VERSION=3
ENV PYTHON_MINOR_VERSION=3.7
ENV PYTHON_FULL_VERSION=3.7.4
RUN wget https://www.python.org/ftp/python/${PYTHON_FULL_VERSION}/Python-${PYTHON_FULL_VERSION}.tgz \
    && tar xzf Python-${PYTHON_FULL_VERSION}.tgz \
    && cd Python-${PYTHON_FULL_VERSION} && ./configure --enable-optimizations && make install \
    && cd /usr/local/bin && ln -s python${PYTHON_MINOR_VERSION} python
RUN curl https://bootstrap.pypa.io/get-pip.py | python

# Haskell environment
RUN apt-get install -y haskell-platform

COPY requirements.txt /sources/
WORKDIR /sources
RUN pip install -r requirements.txt

# Bat commandline (colored cat)
RUN cd ~ \
    && wget https://github.com/sharkdp/bat/releases/download/v0.11.0/bat_0.11.0_amd64.deb \
    && dpkg -i ./bat_0.11.0_amd64.deb

COPY Example.hs program.py fib.pyx setup.py wrapper.c Makefile /sources/