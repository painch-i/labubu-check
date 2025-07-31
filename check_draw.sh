#!/bin/bash

URL="https://popmart.runfair.com/page-data/fr-FR/fr/page-data.json"

now=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

found=$(curl -s "$URL" | jq -r --arg now "$now" '
  .. | objects
  | select(has("eventDate"))
  | select(.eventDate.end > $now)
')

if [[ -n "$found" ]]; then
  echo "true"
else
  echo "false"
fi
