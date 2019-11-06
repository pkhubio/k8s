#!/usr/bin/env bash


aws s3api create-bucket \
    --bucket k8s-pkhub-io-state-store
aws s3api put-bucket-versioning --bucket k8s-pkhub-io-state-store  --versioning-configuration Status=Enabled
aws s3api put-bucket-encryption --bucket k8s-pkhub-io-state-store --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

