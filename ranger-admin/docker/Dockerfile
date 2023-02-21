FROM openjdk:8-jre-slim-buster


RUN apt-get clean
RUN apt-get update
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y install sudo wget bc python apt-transport-https gnupg
RUN wget -O /root/postgresql.jar https://jdbc.postgresql.org/download/postgresql-42.2.23.jar
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9


WORKDIR /root
ADD https://github.com/aakashnand/trino-ranger-demo/releases/download/trino-ranger-demo-v1.0/ranger-2.1.0-admin.tar.gz /root

RUN tar xvf ranger-2.1.0-admin.tar.gz 
RUN mv ranger-2.1.0-admin  ranger-admin

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

ENV JAVA_HOME=/usr/local/openjdk-8