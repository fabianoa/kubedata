FROM trinodb/trino:406

USER root

WORKDIR /root

RUN  curl -L https://github.com/aakashnand/trino-ranger-demo/releases/download/trino-ranger-demo-v1.0/ranger-3.0.0-SNAPSHOT-trino-plugin-405-406.tar.gz --output /root/ranger-plugin.tar.gz

RUN tar xvf ranger-plugin.tar.gz

RUN mv ranger-3.0.0-SNAPSHOT-trino-plugin  ranger-trino-plugin

RUN chown root:root -R /root/ranger-trino-plugin/*

