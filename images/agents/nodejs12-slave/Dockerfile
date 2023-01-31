FROM jenkins/inbound-agent:4.10-3-alpine-jdk11 as base

FROM node:12.22.12-alpine3.15 AS node
FROM base

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

USER jenkins