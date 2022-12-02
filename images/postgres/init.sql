create user "keycloak-admin";
alter role "keycloak-admin" CREATEROLE;
alter user "keycloak-admin" with password 'Admin123';
CREATE DATABASE keycloak;
GRANT ALL PRIVILEGES ON DATABASE keycloak TO "keycloak-admin";
