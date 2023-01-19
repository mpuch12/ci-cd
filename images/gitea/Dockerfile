FROM gitea/gitea:1.18.1
ENV GITEA_CUSTOM=/etc/gitea/
COPY app.ini /etc/gitea/conf/
COPY head_navbar.tmpl /etc/gitea/templates/base/
RUN chmod o+rwx /etc/gitea/conf/app.ini
COPY start.sh .
COPY install.sh .
ENTRYPOINT ["./start.sh"]
