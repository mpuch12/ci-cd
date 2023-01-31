FROM jenkins/inbound-agent:4.11-1-alpine-jdk11

# the jenkins/inbound-agent is configured to run as the `jenkins` user. To install new software & packages, we'll need to change back to `root`
USER root

#Docker CLI and utils
RUN apk add --update docker-cli ca-certificates openrc xmlstarlet python3 jq
#RUN rc-update add docker boot
RUN chmod a+rwx /usr/bin/xml

#Azure CLI
#https://www.rokpoto.com/install-azure-cli-dockerfile-alpine/
RUN apk add py3-pip
RUN apk add gcc musl-dev python3-dev libffi-dev openssl-dev cargo make
RUN pip install --upgrade pip
RUN pip install azure-cli

#kubectl
RUN apk update && apk add curl git
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.26.1/bin/linux/amd64/kubectl
RUN chmod +x kubectl && mv kubectl /bin/kubectl

#helm
RUN curl https://raw.githubusercontent.com/helm/helm/v3.10.3/scripts/get-helm-3 | bash

#istioctl
ENV ISTIO_VERSION=1.16.1
RUN cd /opt &&\
	curl -L https://istio.io/downloadIstio | ISTIO_VERSION="$ISTIO_VERSION" TARGET_ARCH=x86_64 sh - && \
	chmod -R 755 istio-"$ISTIO_VERSION" && \
	chmod -R -x+X istio-"$ISTIO_VERSION" && \
	chmod 755 istio-"$ISTIO_VERSION"/bin/* && \
	ln -s istio-"$ISTIO_VERSION" istio && \
	ln -s /opt/istio/bin/istioctl /usr/local/bin/istioctl

#needed for pushing images to registry
EXPOSE 5000 5001 5002

RUN apk add gnupg

USER jenkins
