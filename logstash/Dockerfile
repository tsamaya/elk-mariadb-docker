FROM elastic/logstash:7.4.2

RUN bin/logstash-plugin install logstash-input-jdbc

COPY ./mariadb-java-client-2.4.4.jar /opt/mariadb-java-client-2.4.4.jar
# COPY ./mysql-connector-java-8.0.18.jar /opt/mysql-connector-java-8.0.18.jar

COPY ./logstash.yml /usr/share/logstash/config/logstash.yml

COPY ./logstash.conf /usr/share/logstash/pipeline/logstash.conf
