FROM debian:latest
ARG build_branch=master
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    sudo
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get update && apt-get install -y nodejs
RUN npm install -g grunt-cli
RUN apt-get update && \
    apt-get install --force-yes -yq \
    wget \
    autoconf \
    build-essential \
    libcurl4-gnutls-dev \
    libglib2.0-dev \
    libgdk-pixbuf2.0-dev \
    libgtkglext1-dev \
    libatk1.0-dev \
    libcairo2-dev \
    libtool \
    libxml2-dev \
    libxss-dev \
    libgconf2-dev \
    default-jre \
    qt5-qmake \
    qt5-default  \
    p7zip-full \
    git \
    subversion
RUN git clone --recursive https://github.com/ONLYOFFICE/DocumentServer.git
RUN cd DocumentServer && git submodule foreach --recursive git checkout $build_branch
RUN cd DocumentServer/core/Common/3dParty && ./make.sh
RUN cd DocumentServer/core && make
RUN cd DocumentServer/sdkjs && make
RUN cd DocumentServer/server && make
# enable multiverse for ttf-mscorefonts-installer
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty multiverse" | tee -a /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y \
    adduser \
    redis-server \
    rabbitmq-server \
    nodejs \
    libstdc++6 \
    libcurl3 \
    libxml2 \
    libboost-regex-dev \
    zlib1g \
    fonts-dejavu \
    fonts-liberation \
    ttf-mscorefonts-installer \
    fonts-crosextra-carlito \
    fonts-takao-gothic \
    fonts-opensymbol \
    libxss1 \
    libcairo2 \
    xvfb \
    libxtst6 \
    libgconf2-4 \
    libasound2
RUN cd DocumentServer/server && make install
RUN apt-get update && apt-get install -y nginx
RUN rm -f /etc/nginx/sites-enabled/default
COPY onlyoffice-documentserver /etc/nginx/sites-available/onlyoffice-documentserver
RUN ln -s /etc/nginx/sites-available/onlyoffice-documentserver /etc/nginx/sites-enabled/onlyoffice-documentserver
RUN apt-get update && apt-get install -y postgresql
RUN service postgresql start && \
    sudo -u postgres psql -c "CREATE DATABASE onlyoffice;" && \
    sudo -u postgres psql -c "CREATE USER onlyoffice WITH password 'onlyoffice';" && \
    sudo -u postgres psql -c "GRANT ALL privileges ON DATABASE onlyoffice TO onlyoffice;"
RUN service postgresql start && \
# Workaround https://bugs.launchpad.net/ubuntu/+source/postgresql-9.5/+bug/1826847
    sleep 30 && \ 
    PGPASSWORD=onlyoffice psql -hlocalhost -Uonlyoffice -d onlyoffice -f /var/www/onlyoffice/documentserver/server/schema/postgresql/createdb.sql
EXPOSE 80
CMD service postgresql start && \
    service rabbitmq-server start && \
    service redis-server start && \
    service nginx start && \
    service postgresql start && \
    (cd /var/www/onlyoffice/documentserver/server/FileConverter/sources/ && \
    export NODE_ENV=production-linux NODE_CONFIG_DIR=/etc/onlyoffice/documentserver && \
    sudo -u onlyoffice -E node /var/www/onlyoffice/documentserver/server/FileConverter/sources/convertermaster.js &) && \
    (export NODE_ENV=production-linux NODE_CONFIG_DIR=/etc/onlyoffice/documentserver && \
    sudo -u onlyoffice -E node /var/www/onlyoffice/documentserver/server/SpellChecker/sources/server.js &) && \
    (export NODE_ENV=production-linux NODE_CONFIG_DIR=/etc/onlyoffice/documentserver && \
    sudo -u onlyoffice -E node /var/www/onlyoffice/documentserver/server/DocService/sources/server.js &) && \
    bash
