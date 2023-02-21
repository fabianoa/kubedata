FROM trinodb/trino:384

ENV RANGER_VERSION 2.1.0

WORKDIR /root

RUN curl https://github.com/aakashnand/trino-ranger-demo/releases/download/trino-ranger-demo-v1.0/ranger-2.1.0-trino-plugin.tar.gz --output ranger-2.1.0-trino-plugin.tar.gz -L

RUN tar xvf ranger-2.1.0-trino-plugin.tar.gz

RUN mv ranger-2.1.0-trino-plugin  ranger-trino-plugin

RUN chown root:root -R /root/ranger-trino-plugin/*

