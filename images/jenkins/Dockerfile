FROM jenkins/jenkins:2.367
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV JENKINS_OPTS --prefix=/jenkins
ENV CASC_JENKINS_CONFIG /usr/casc.yaml
COPY casc.yaml /usr/casc.yaml
COPY plugins.txt /usr/
RUN /bin/jenkins-plugin-cli --plugin-file /usr/plugins.txt
