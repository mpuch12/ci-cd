#!/bin/bash

trap "{ echo 'Terminated with Ctrl+C'; }" SIGINT
echo "Executing entrypoint"
/usr/bin/entrypoint &

sleep 5


echo "Executing post request to run web install wizard"
curl --request POST \
  --url http://localhost:3000/ \
  --header 'Content-Type: multipart/form-data' \
  --cookie i_like_gitea=738eb85bf3ad0b1f \
  --form db_type=sqlite3 \
  --form db_host=localhost:3306 \
  --form db_user=root \
  --form db_name=gitea \
  --form ssl_mode=disable \
  --form charset=utf8 \
  --form db_path=/data/gitea/gitea.db \
  --form app_name=Gitea \
  --form repo_root_path=/data/git/repositories \
  --form lfs_root_path=/data/git/lfs \
  --form run_user=git \
  --form domain=localhost \
  --form ssh_port=22 \
  --form http_port=3000 \
  --form app_url=http://localhost \
  --form log_root_path=/data/gitea/log \
  --form enable_federated_avatar=on \
  --form enable_open_id_sign_in=off \
  --form enable_open_id_sign_up=off \
  --form default_allow_create_organization=off \
  --form default_enable_timetracking=off \
  --form no_reply_address=noreply.localhost \
  --form password_algorithm=pbkdf2
  
sleep 5

echo "Deploy configuration"
cp app.ini $GITEA_CUSTOM/conf/
su -c 'gitea admin user create --admin --username ci_admin --password admin --email ci_admin@localhost --must-change-password=false' git
su -c 'gitea admin user create --username jenkins --password jenkins --email jenkins@localhost --must-change-password=false' git

wait

