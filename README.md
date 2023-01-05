# CI-CD

## Overview

This project a collection of integrated tools to create a CI/CD environment. With role-based access using OAuth2.0 provided with keycloak.

It consists of:

* Gitea as a code repository and an artifact repository
* Jenkins to build applications based on defined pipelines
* Nginx proxy
* Keycloak for user authentication via oAuth2.0
* Postgres for storing data


## Quickstart

### Configuration at start
1. Fill .env file with appropriate values
2. Add valid SSL certificate for chosen domain under path `/config/proxy/certs`
3. Change environment variables storing secrets in `/config` sub-folders 
4. Run stack using `docker compose up -d`
5. Verify if services are available
   1. `https://<your-domain>/keycloak` - Keycloak admin panel UI
   2. `https://<your-domain>/jenkins` - Jenkins UI
   3. `https://<your-domain>/gitea` - Gitea UI
6. Login to keycloak admin panel. Add users in realm `ci_cd`. One in group `developer` and second in group `admin`
7. Change password (on first login) for gitea users  (`ci_admin`, `jenkins`). Default password for both `change_me`
8. Login to gitea with `jenkins` user. Create access token and add it as secret in jenkins (kind: `Gitea Personal Access Token`)
9. Login with users in admin group to jenkins and go to `Manage Jenkins -> Configure System -> Gitea Servers`. Check `manage hooks` and set credentials to secret from step 10 
10. Stack is now ready to use


## Notes

For users logged in to gitea using openid connect as git command password should use generated access token in https connection
