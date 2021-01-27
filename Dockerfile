FROM ubuntu:focal
LABEL maintainer="tristan.glatard@concordia.ca"

# Install Python and other required packages
RUN : \
    && apt-get -yq update \
    && apt-get install -yq --no-install-recommends \
        python3-dev \
        python3-pip \
        curl \
        openssh-client \
        netbase \
        g++ \
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

# Install Python dependencies
RUN  pip install datalad==0.13.1 boutiques notebook==5.* nilearn

# Install fslstats
ADD fslstats /bin

# Create Binder user, see https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# Configure Git
ENV PATH="/git-annex.linux:${PATH}"
RUN : \
    && git config --global user.email "example@example.org" \
    && git config --global user.name "HIBALL Winter School container" \
    && :

# disinherit previous entrypoints
ENTRYPOINT []

# Hack Boutiques descriptor to run on baremetal rather than in container
RUN mkdir -p ${HOME}/.cache/boutiques/production
ADD zenodo-4472771.json /${HOME}/.cache/boutiques/production
ENV FSLOUTPUTTYPE=NIFTI_GZ
