#!/usr/bin/env bash


DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

"$DIR"/kubectl create clusterrolebinding default-admin --clusterrole cluster-admin --serviceaccount=default:default
"$DIR"/kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
"$DIR"/kubectl apply -f "$DIR/../services/ingress/service-l7.yaml"

"$DIR"/kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/aws/patch-configmap-l7.yaml

