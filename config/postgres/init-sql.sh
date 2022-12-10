#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    create user "keycloak-admin";
    alter role "keycloak-admin" CREATEROLE;
    alter user "keycloak-admin" with password '${JENKINS_ADMIN_PASSWORD}';
    CREATE DATABASE keycloak;
    GRANT ALL PRIVILEGES ON DATABASE keycloak TO "keycloak-admin";

    create user "gitea-admin";
    alter role "gitea-admin" CREATEROLE;
    alter user "gitea-admin" with password '${GITEA_ADMIN_PASSWORD}';
    CREATE DATABASE gitea;
    GRANT ALL PRIVILEGES ON DATABASE gitea TO "gitea-admin";
EOSQL
