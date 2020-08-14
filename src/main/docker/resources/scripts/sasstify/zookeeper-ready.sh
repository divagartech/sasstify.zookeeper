#!/usr/bin/env bash

ERROR=$(curl -sb -H "Accept: application/json" "http://localhost:8080/commands/ruok" | jq -r ".error")
if [ "$ERROR" == "null" ]; then
	exit 0
else
	exit 1
fi