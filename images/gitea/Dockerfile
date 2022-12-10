FROM gitea/gitea:1.17.2
ENV GITEA_CUSTOM=/etc/gitea/
COPY app.ini /etc/gitea/conf/
COPY start.sh .
COPY install.sh .
ENTRYPOINT ["./start.sh"]
