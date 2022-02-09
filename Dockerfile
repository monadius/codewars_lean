FROM ubuntu:18.04

RUN set -ex; \
    useradd --create-home -u 9999 codewarrior; \
    mkdir -p /workspace; \
    chown -R codewarrior:codewarrior /workspace;

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        wget \
        ca-certificates \
        git \
        python3-pip \
        python3-setuptools \
    ; \
# Install `leanproject`
    pip3 install -Iv mathlibtools==0.0.10; \
    rm -rf /tmp/* /var/lib/apt/lists/*;

USER codewarrior
# Install Elan to manage Lean versions
RUN set -ex; \
    cd /tmp; \
    wget -q https://github.com/Kha/elan/releases/download/v0.10.2/elan-x86_64-unknown-linux-gnu.tar.gz; \
    tar xf elan-x86_64-unknown-linux-gnu.tar.gz; \
    rm elan-x86_64-unknown-linux-gnu.tar.gz; \
    ./elan-init -y --no-modify-path; \
    rm elan-init;
ENV PATH=/home/codewarrior/.elan/bin:$PATH

WORKDIR /workspace
COPY --chown=codewarrior:codewarrior leanpkg.toml /workspace/leanpkg.toml
RUN set -ex; \
    cd /workspace; \
# `leanproject` command requires git repository
    git init -q; \
    mkdir src; \
    mkdir test; \
# Get mathlib olean files
    leanproject get-mathlib-cache; \
# Check timestamps are correct
    leanproject check;
