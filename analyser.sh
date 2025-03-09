#!/bin/bash

# This scrpit analysis nginx logs

LOG_FILE='./nginx-access.log'

# Clear terminal window
clear

# Check if LOG_FILE exists and is a file
if [[ ! -e "${LOG_FILE}" ]]
then
  echo "Cannot open ${LOG_FILE}" >&2
  exit 1
fi

# Top 5 IP addresses with the most requests
echo "Top 5 IP addresses with the most requests:"
cut -d " " -f 1 "${LOG_FILE}" | sort | uniq -c | sort -rn | head -5 | awk '{ print $2, "-", $1, "requests" }'
echo

# Top 5 most requested paths
echo "Top 5 most requested paths:"
cut -d " " -f 7 "${LOG_FILE}" | sort | uniq -c | sort -rn | head -5 | awk '{ print $2, "-", $1, "requests" }'
echo

# Top 5 response status codes
echo "Top 5 response status codes:"
cut -d '"' -f 3 "${LOG_FILE}" | cut -d " " -f 2 | sort | uniq -c | sort -rn | head -5 | awk '{ print $2, "-", $1, "requests" }'
echo

# Top 5 user agents
echo "Top 5 user agents:"
cut -d '"' -f 6 "${LOG_FILE}" | sort | uniq -c | sort -rn | head -5 | awk '{ first = $1; $1=""; print $0, "-", first, "requests" }' | cut -c 2-
echo