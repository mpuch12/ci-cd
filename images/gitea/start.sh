#!/bin/bash

trap "{ echo 'Terminated with Ctrl+C'; }" SIGINT
echo "Executing entrypoint"
/usr/bin/entrypoint &

bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:3000)" != "200" ]]; do sleep 2; done'  

echo "Create users"
su -c 'gitea admin user create --admin --username ci_admin --password change_me --email ci_admin@localhost --must-change-password=true' git
su -c 'gitea admin user create --username jenkins --password change_me --email jenkins@localhost --must-change-password=true' git

echo "Add keycloak oauth"
su -c 'gitea admin auth add-oauth --name keycloak --provider openidConnect --key gitea --secret ${GITEA_CLIENT_SECRET} --auto-discover-url http://keycloak:8080/keycloak/realms/ci_cd/.well-known/openid-configuration' git
wait

