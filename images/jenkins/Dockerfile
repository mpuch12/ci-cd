FROM jenkins/jenkins:2.381
USER root
RUN apt-get update -qq \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update  -qq \
    && apt-get -y install docker-ce-cli
USER jenkins
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV JENKINS_OPTS --prefix=/jenkins
ENV CASC_JENKINS_CONFIG /usr/casc.yaml
COPY plugins.txt /usr/
RUN /bin/jenkins-plugin-cli --plugin-file /usr/plugins.txt

