#!/usr/bin/env bash


DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

set -e

export PGPASSWORD=$(kubectl get secret postgres.acid-minimal-cluster.credentials -o 'jsonpath={.data.password}' | base64 -d)
export PGHOST="localhost"
export PGPORT="5432"

"$DIR"/kubectl port-forward service/acid-minimal-cluster-repl 5432:5432 &

sleep 5s

psql -U postgres
