FROM gitpod/workspace-postgres:latest

USER gitpod

RUN sudo apt-get update \
    && sudo apt-get install -yq --no-install-recommends \
        libpq-dev \
        libecpg-dev \
    && sudo apt-get -y clean \
    && sudo rm -rf /var/lib/apt/lists/*
