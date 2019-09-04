FROM ubuntu:18.04
ARG NPM_VERSION=6.1.0
ARG NODE_VERSION=10.7.0
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install nodejs npm curl -y
RUN npm install -g npm@$NPM_VERSION && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
RUN export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \
    . "$NVM_DIR/nvm.sh"  && \
    [ -s "$NVM_DIR/bash_completion" ] && \
    . "$NVM_DIR/bash_completion" && \
    nvm install $NODE_VERSION
