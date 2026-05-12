FROM openjdk:8-jre-slim

LABEL maintainer="KnowStreaming"
LABEL description="Know Streaming - Kafka Management Platform - Backend"

RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/ks/conf /opt/ks/libs /opt/ks/logs

COPY km-rest/target/ks-km.jar /opt/ks/libs/ks-km.jar
COPY docker/manager/application.yml /opt/ks/conf/application.yml
COPY docker/manager/entrypoint.sh /opt/ks/entrypoint.sh
COPY docker/manager/logback-spring.xml /opt/ks/conf/logback-spring.xml

RUN chmod +x /opt/ks/entrypoint.sh

EXPOSE 80

WORKDIR /opt/ks

ENTRYPOINT ["/opt/ks/entrypoint.sh"]
