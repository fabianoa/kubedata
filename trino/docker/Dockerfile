FROM trinodb/trino:389

USER root


WORKDIR /root



RUN  curl -L  https://github.com/aakashnand/trino-ranger-demo/releases/download/trino-ranger-demo-v1.0/ranger-2.3.0-trino-plugin.tar.gz --output /root/ranger-2.3.0-trino-plugin.tar.gz

RUN tar xvf ranger-2.3.0-trino-plugin.tar.gz

RUN mv ranger-2.3.0-trino-plugin  ranger-trino-plugin

RUN chown root:root -R /root/ranger-trino-plugin/*

