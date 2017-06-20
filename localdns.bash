#!/usr/bin/env bash

USER_ID=$(id -u)

if [[ $USER_ID != 0 ]]; then
  sudo "$0" $*
  exit $?
fi

RESOLV_FILE='/etc/resolv.conf'
LOCAL_DNS_IP='127.0.0.1'
NON_LOCAL_DNS_IP='8.8.8.8'

function change_resolve_ip() {
  local new_ip="$1"
  sed -i "s/nameserver .*/nameserver ${new_ip}/" "${RESOLV_FILE}"
}

if [[ $1 == 'on' ]]; then
  change_resolve_ip "${LOCAL_DNS_IP}"
elif [[ $1 == 'off' ]]; then
  change_resolve_ip "${NON_LOCAL_DNS_IP}"
else
  echo "USAGE: $0 [on|off]"
  exit 1
fi
