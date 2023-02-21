FROM trinodb/trino:384

USER root


WORKDIR /root

RUN  curl https://github.com/aakashnand/trino-ranger-demo/releases/download/trino-ranger-demo-v1.0/ranger-2.1.0-trino-plugin.tar.gz --output /root/ranger-2.1.0-trino-plugin.tar.gz

RUN tar xvf ranger-2.1.0-trino-plugin.tar.gz

RUN mv ranger-2.1.0-trino-plugin  ranger-trino-plugin

RUN chown root:root -R /root/ranger-trino-plugin/*

