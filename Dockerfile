FROM ubuntu:22.04

RUN set -ex; \
    useradd --create-home codewarrior; \
    mkdir -p /workspace; \
    chown -R codewarrior:codewarrior /workspace;

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        curl \
        wget \
        ca-certificates \
        git \
    ; \
    rm -rf /tmp/* /var/lib/apt/lists/*;

USER codewarrior

# Install Elan to manage Lean versions
RUN set -ex; \
    cd /tmp; \
    wget -q https://github.com/leanprover/elan/releases/download/v3.1.1/elan-x86_64-unknown-linux-gnu.tar.gz; \
    tar xf elan-x86_64-unknown-linux-gnu.tar.gz; \
    ./elan-init -y --no-modify-path --default-toolchain leanprover/lean4:v4.6.0; \
    rm elan-init elan-x86_64-unknown-linux-gnu.tar.gz;

ENV PATH=/home/codewarrior/.elan/bin:$PATH

WORKDIR /workspace

# Create an empty project and copy config files
RUN set -ex; lake init Kata; rm Kata/Basic.lean;
COPY --chown=codewarrior:codewarrior \
    Kata.lean \
    lakefile.lean \
    lean-toolchain \
    /workspace/

# Get precompiled Mathlib files
RUN set -ex; \
    cd /workspace; \
    lake exe cache get;

COPY --chown=codewarrior:codewarrior \
    Kata/CodewarsTests.lean \
    /workspace/Kata/CodewarsTests.lean
