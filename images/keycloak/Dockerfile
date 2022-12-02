FROM quay.io/keycloak/keycloak:20.0.1 as builder
ENV KC_DB=postgres
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:20.0.1
COPY --from=builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak/bin/
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--import-realm"]
