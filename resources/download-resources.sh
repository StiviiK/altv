#!/usr/bin/env bash
BASE_URL=$(jq "._baseUrl" urls.json)
echo $BASE_URL
jq '.stable | to_entries[] | .key' urls.json  | while read i; do
    TEST=$(jq ".stable.${i}" urls.json)
    echo "${BASE_URL}${TEST}"
done