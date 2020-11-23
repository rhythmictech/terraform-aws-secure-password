#! /usr/bin/env bash
ARGS=($(jq -r --unbuffered '.repo_full_name,.tag'))
curl -Ls "https://github.com/${ARGS[0]}/releases/download/${ARGS[1]}/lambda.sha256base64" | jq -cR '{"sha": .}'
