FROM ubuntu:focal
LABEL maintainer="tristan.glatard@concordia.ca"

RUN : \
    && apt-get -yq update \
    && apt-get install -yq --no-install-recommends \
        python3-dev \
        python3-pip \
        curl \
        openssh-client \
        netbase \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && :

# Retrieve the binaries for the latest version of git-annex.
RUN : \
    && curl \
        https://downloads.kitenet.net/git-annex/linux/current/git-annex-standalone-amd64.tar.gz \
        | tar -zxvf - \
    && sh /git-annex.linux/runshell \
    && :
ENV PATH="/git-annex.linux:${PATH}"

# Install DataLad and Boutiques
RUN pip install datalad==0.13.1 boutiques

# Configure Git
# Setup Git for GitHub Actions
RUN : \
    && git config --global user.email "example@example.org" \
    && git config --global user.name "HIBALL Winter School container" \
    && :

RUN mkdir -p /root/.cache/boutiques/production
ADD fslstats /bin
ADD zenodo-4472771.json /root/.cache/boutiques/production