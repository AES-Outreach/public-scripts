#!/bin/sh
set -e

secret="$AWS_SECRET_ID"

if [ -n "$1" ]; then
    secret="$1"
fi

if [ -n "$secret" ]
then
    echo 'fetching secrets...'
    aws secretsmanager get-secret-value --secret-id ${secret} --query SecretString --output text | jq -r 'to_entries|map("export \(.key)=\(.value|tostring)")|.[]' >> /tmp/secrets.env
fi
