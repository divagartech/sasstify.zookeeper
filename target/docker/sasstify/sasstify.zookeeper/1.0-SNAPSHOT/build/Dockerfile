FROM bitnami/zookeeper:latest

ARG artifact_id
ARG version

LABEL com.sasstify.project.name = $artifact_id \
      com.sasstify.project.version = $version

USER root

RUN install_packages jq

RUN mkdir -p /opt/sasstify/scripts/zookeeper
COPY resources/scripts/sasstify /opt/sasstify/scripts/zookeeper
RUN chmod +x /opt/sasstify/scripts/zookeeper/*
COPY resources/scripts/bitnami/entrypoint.sh /opt/bitnami/scripts/zookeeper/entrypoint.sh
RUN chmod +x /opt/bitnami/scripts/zookeeper/entrypoint.sh
