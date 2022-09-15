FROM node:18.9.0 as builder
RUN git clone https://github.com/go-gitea/gitea.git && cd gitea && git checkout tags/v1.17.2 -b master && make frontend

FROM nginx:1.23.1
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /gitea/public /static/
