#!/bin/bash

echo "Content-type: application/octet-stream"
echo


shell_get_value()
{
  local GET_VALUE=`echo $QUERY_STRING | sed -n "s/^.*$1=\\([^&]*\\).*$/\\1/p"`
  echo $GET_VALUE
}


SHELL_CONFIG_USR_SHARE="/usr/share/kbcom.net-cm/management-server"

SHELL_GET_HOST="hostname from apache"
SHELL_GET_TYPE=$(shell_get_value type)

case "$SHELL_GET_TYPE" in
packages)
 "$SHELL_CONFIG_USR_SHARE/management.bash" "$SHELL_GET_HOST" "$SHELL_GET_TYPE"
 ;;
*)
 env
esac
