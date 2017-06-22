#!/bin/bash

/bin/echo "Content-type: application/octet-stream"
/bin/echo


shell_get_value()
{
  local GET_VALUE=`echo $QUERY_STRING | sed -n "s/^.*$1=\\([^&]*\\).*$/\\1/p"`
  echo $GET_VALUE
}


CONFIG_FOLDER_MANAGER_CONFIG="/etc/kbcom.net-cm/manager-server"
SHELL_CONFIG_USR_SHARE="/usr/share/kbcom.net-cm/manager-server"

SHELL_GET_HOST=$(/bin/echo $SSL_CLIENT_S_DN_CN | /bin/grep -oE '[^ ]+$')
SHELL_GET_TYPE=$(shell_get_value type)


case "$SHELL_GET_TYPE" in
packages)
 "$SHELL_CONFIG_USR_SHARE/kbcom.net-cm-manager-server-packages.bash" "$CONFIG_FOLDER_MANAGER_CONFIG" "$SHELL_GET_HOST"
 ;;
*)
 env
esac
