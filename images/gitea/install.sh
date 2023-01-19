#!/bin/bash


waitForSuccessfulConnection() {
  local counter=1
  local max_attempts=30

  while :; do
    echo "Attempt no: $counter/$max_attempts trying to connect with $1"
    [[ "$(curl -s -o /dev/null -w ''%{http_code}'' $1)" != "200" ]] || break
    [[ "$counter" -lt "$max_attempts" ]] || break
    sleep 2
    counter=$((counter + 1))
  done
}

waitForSuccessfulConnection "localhost:3000"


is_ci_admin_user_exists=$(gitea admin user list | grep "ci_admin")

if [[ -z "$is_ci_admin_user_exists" ]]; then
  gitea admin user create --admin --username ci_admin --password change_me --email ci_admin@localhost --must-change-password=true
else
  echo "Skipped creating user ci_admin"
fi

is_jenkins_user_exists=$(gitea admin user list | grep "jenkins")

if [[ -z "$is_jenkins_user_exists" ]]; then
  gitea admin user create --username jenkins --password change_me --email jenkins@localhost --must-change-password=true
else
  echo "Skipped creating user jenkins"
fi


is_keycloak_auth_exists=$(gitea admin auth list | grep "keycloak")

if [ -z "$is_keycloak_auth_exists" ]; then
  echo "Waiting for keycloak connection"
  waitForSuccessfulConnection "http://keycloak:8080/keycloak/realms/ci_cd/.well-known/openid-configuration"
  
  gitea admin auth add-oauth \
    --name keycloak \
    --provider openidConnect \
    --key gitea \
    --secret ${GITEA_CLIENT_SECRET} \
    --auto-discover-url http://keycloak:8080/keycloak/realms/ci_cd/.well-known/openid-configuration
   echo "Keycloak oauth created successfully"
else
  echo "Skipped creating keycloak oauth"
fi