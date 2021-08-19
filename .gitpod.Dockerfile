FROM gitpod/workspace-postgres:latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libpq-dev \
        libecpg-dev \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*
