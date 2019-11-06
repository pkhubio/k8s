#/usr/bin/env bash


ID=$(uuidgen) && aws route53 create-hosted-zone --name k8s.pkhub.io --caller-reference $ID | jq .DelegationSet.NameServers

