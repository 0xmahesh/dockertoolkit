#Installing Machine 
FROM ubuntu:18.04

#Label
LABEL maintainer="Mahesh Kasbe"

# Environment Variables
ENV HOME /root
ENV DEBIAN_FRONTEND=noninteractive


# Working Directory
WORKDIR /root
RUN mkdir ${HOME}/tools && \
    mkdir ${HOME}/wordlist

# Installing Essentials
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    iputils-ping\
    git \
    vim \
    wget\
    curl \
    make \
    nmap \
    whois \
    python \
    python-pip \
    python3 \
    python3-pip \
    perl \
    nikto \
    dnsutils \
    net-tools \
    nano\
    && rm -rf /var/lib/apt/lists/*
# Installing Dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    # sqlmap
    sqlmap \
    # dirb
    dirb \
    # massdns
    libldns-dev \
    # wpcscan
    libcurl4-openssl-dev \
    libxml2 \
    libxml2-dev \
    libxslt1-dev \
    ruby-dev \
    libgmp-dev \
    zlib1g-dev \
# masscan
    libpcap-dev \
    # hydra
    hydra \
    && rm -rf /var/lib/apt/lists/*

# configure python(s)
RUN python -m pip install --upgrade setuptools && python3 -m pip install --upgrade setuptools

# Sublist3r
RUN cd ${HOME}/tools && \
    git clone https://github.com/aboul3la/Sublist3r.git && \
    cd Sublist3r/ && \
    pip install -r requirements.txt && \
    ln -s ${HOME}/tools/Sublist3r/sublist3r.py /usr/local/bin/sublist3r

# wfuzz
RUN pip install wfuzz

# seclists
RUN cd ${HOME}/wordlist && \
    git clone --depth 1 https://github.com/danielmiessler/SecLists.git

# massdns
RUN cd ${HOME}/tools && \
    git clone https://github.com/blechschmidt/massdns.git && \
    cd massdns/ && \
    make && \
    ln -sf ${HOME}/tools/massdns/bin/massdns /usr/local/bin/massdns

# wafw00f
RUN cd ${HOME}/tools && \
    git clone https://github.com/enablesecurity/wafw00f.git && \
    cd wafw00f && \
    chmod +x setup.py && \
    python setup.py install

# wpscan
RUN cd ${HOME}/tools && \
    git clone https://github.com/wpscanteam/wpscan.git && \
cd wpscan/ && \
    gem install bundler && bundle install --without test && \
    gem install wpscan

# commix 
RUN cd ${HOME}/tools && \
    git clone https://github.com/commixproject/commix.git && \
    cd commix && \
    chmod +x commix.py && \
    ln -sf ${HOME}/tools/commix/commix.py /usr/local/bin/commix

# masscan
RUN cd ${HOME}/tools && \
    git clone https://github.com/robertdavidgraham/masscan.git && \
    cd masscan && \
    make && \
    ln -sf ${HOME}/tools/masscan/bin/masscan /usr/local/bin/masscan

# XSStrike
RUN cd ${HOME}/tools && \
    git clone https://github.com/s0md3v/XSStrike.git && \
    cd XSStrike && \
    pip3 install -r requirements.txt && \
    chmod +x xsstrike.py && \
    ln -sf ${HOME}/tools/XSStrike/xsstrike.py /usr/local/bin/xsstrike

# gobuster
RUN cd ${HOME}/tools && \
    git clone https://github.com/OJ/gobuster.git && \
    cd gobuster && \
    go get && go install

# fierce
RUN python3 -m pip install fierce
