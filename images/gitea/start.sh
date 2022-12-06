#!/bin/bash

trap "{ echo 'Terminated with Ctrl+C'; }" SIGINT
echo "Executing entrypoint"
/usr/bin/entrypoint &

bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:3000)" != "200" ]]; do sleep 2; done'  

su -c './install.sh' git

wait

