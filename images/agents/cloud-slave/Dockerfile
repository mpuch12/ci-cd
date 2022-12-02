FROM jenkins/inbound-agent:4.11-1-alpine-jdk11

# the jenkins/inbound-agent is configured to run as the `jenkins` user. To install new software & packages, we'll need to change back to `root`
USER root

#TODO install docker cli only
RUN apk add --update docker openrc
RUN rc-update add docker boot

# now that we've finished customizing our Jenkins image, we should drop back to the `jenkins` user.
USER jenkins

