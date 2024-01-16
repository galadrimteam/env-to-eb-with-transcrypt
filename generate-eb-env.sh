#!/bin/bash

ENV_FILE=$1
CONFIG_FILE=$2

mkdir -p "$(dirname "$CONFIG_FILE")"
touch "$CONFIG_FILE"

{
    echo "option_settings:"
    echo $'  aws:elasticbeanstalk:application:environment:'
} >>"$CONFIG_FILE"

while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" != \#* ]] && [[ -n "$line" ]]; then
        echo $'    '"${line/=/: }" >>"$CONFIG_FILE"
    fi
done <"$ENV_FILE"
