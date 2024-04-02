FROM kadensungbincho/ranger-usersync:2.1.0

ADD templates /

COPY conf.dist/log4j.properties /opt/ranger_usersync/conf.dist/log4j.properties

COPY entrypoint.sh /opt/ranger_usersync/bootstrap.sh
RUN chmod +x /opt/ranger_usersync/bootstrap.sh
