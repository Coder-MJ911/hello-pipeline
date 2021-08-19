#!/usr/bin/env bash

set -euo pipefail

ENV_TAG="$1"
sh .buildkite/set-env-${ENV_TAG}.sh

PWD=$(aws ssm get-parameter --name "password-key" --with-decryption | jq -r '.Parameter.Value') #just a example for get the password from ssm
HOST=`buildkite-agent meta-data get 'db_host'`

docker-compose run -e DB_PASSWORD=$PWD -e DB_HOST=$HOST migration