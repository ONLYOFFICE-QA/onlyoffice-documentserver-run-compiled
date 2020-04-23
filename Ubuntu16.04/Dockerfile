FROM ubuntu:16.04

RUN apt-get -y update && \
    apt-get -y install nginx \
                       postgresql \
                       rabbitmq-server \
                       sudo

RUN rm /etc/nginx/sites-enabled/default 
ADD onlyoffice-documentserver /etc/nginx/sites-available/onlyoffice-documentserver
RUN ln -s /etc/nginx/sites-available/onlyoffice-documentserver /etc/nginx/sites-enabled/onlyoffice-documentserver
ADD entrypoint.sh /entrypoint.sh
CMD ["bash", "/entrypoint.sh"]
