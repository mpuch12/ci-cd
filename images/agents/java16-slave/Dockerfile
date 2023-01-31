FROM jenkins/inbound-agent:4.10-3-alpine-jdk11 as base

FROM adoptopenjdk/openjdk16:jdk-16.0.2_7-alpine as java

FROM base
COPY --from=java /opt/java/openjdk /opt/java/openjdk
USER root
RUN apk update && apk upgrade
RUN apk add maven=3.6.3-r1
RUN mkdir -p .m2/repository && chown -R jenkins.jenkins .m2

USER jenkins