#!/usr/bin/env bash

# Why have I spent three years of my life dealing with EKS kubectl being a slow piece of shit when all it took was 20 minutes
# writing this stupid ass fucking script the amount of time I have wasted staring at blank kubectl outputs waiting for the
# thing to decide it wants to give me a god damn output I would estimate this has accumulated to hours of me staring blankly
# at my screen while this troll fetches a new token every god damn time I make a request FUCK MAN COMMON IT EVEN HAS AN
# EXPIRY BUILT INTO THE FUCKING OUTPUT BUT WHY WOULD IT USE IT WHEN IT CAN JUST MAKE A NEW REQUEST EVERY TIME AMIRITE?!

set -e

cache_file="${HOME}/.journey/kube-auth-cache.json"

profile="${1}"
cluster="${2}"
region="${3}"

key="${region}-${cluster}-${profile}"

cache="{}"
if [ -f "${cache_file}" ]; then
  cache=$(cat "${cache_file}")
fi

cached_token=$(echo "${cache}" | jq -r --arg key "${key}" '.[$key] //empty')

token=""
if [[ ! -z "${cached_token}" ]]; then
  expires_at=$(echo "${cached_token}" | jq -r '.status.expirationTimestamp')
  expires_at=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "${expires_at}" "+%s")
  now=$(date "+%s")

  # remove 30s from date to account for jitter
  if [[ now -ge $(($expires_at - 30)) ]]; then
    token="${cached_token}"
  fi
fi

if [[ ! -z "${token}" ]]; then
  echo "${token}"
  exit 0
fi

token=$(aws-vault exec ${profile} -- aws eks get-token --region=${region} --cluster-name=${cluster})

echo "${cache}" | jq --arg key "${key}" --arg token "${token}" '. + {($key): $token}' > "${cache_file}"

echo "${token}"
