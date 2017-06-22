#!/bin/bash

GLOBAL_FOLDER_SCRIPT=$(/usr/bin/dirname "$0")
GLOBAL_FOLDER_CONFIG=$1
GLOBAL_HOSTNAME_CLIENT=$2

source "$GLOBAL_FOLDER_SCRIPT/.kbcom.net-cm-manager-server.bash"


GLOBAL_PACKAGES_CONFIG_FILES=$(collect_dir_list_configfiles "$GLOBAL_HOSTNAME_CLIENT" "$GLOBAL_FOLDER_CONFIG" packages)
[ $? -eq 0 ] || { /bin/echo "$GLOBAL_PACKAGES_CONFIG_FILES"; exit 1; }

GLOBAL_PACKAGES_PURGE=$(collect_configfiles_list_entries "$GLOBAL_PACKAGES_CONFIG_FILES" "package-purge")
[ $? -eq 0 ] || { /bin/echo $GLOBAL_PACKAGES_PURGE; exit 1; }

GLOBAL_PACKAGES_INSTALL=$(collect_configfiles_list_entries "$GLOBAL_PACKAGES_CONFIG_FILES" "package-install")
[ $? -eq 0 ] || { /bin/echo $GLOBAL_PACKAGES_INSTALL; exit 1; }


GLOBAL_PACKAGES_SAME=$(collect_list_list_sameentries "$GLOBAL_PACKAGES_PURGE" "$GLOBAL_PACKAGES_INSTALL")
[ $? -eq 0 ] || { /bin/echo $GLOBAL_PACKAGES_SAME; exit 1; }


if [ ! -z "$GLOBAL_PACKAGES_SAME" ]
then
 /bin/echo "ERROR"
 collect_configfiles_list_fullentries "$GLOBAL_PACKAGES_CONFIG_FILES" "package-purge" "$GLOBAL_PACKAGES_SAME"
 collect_configfiles_list_fullentries "$GLOBAL_PACKAGES_CONFIG_FILES" "package-install" "$GLOBAL_PACKAGES_SAME"
 exit 1
fi

/bin/echo "OK"
/bin/echo "package-purge $GLOBAL_PACKAGES_PURGE"
/bin/echo "package-install $GLOBAL_PACKAGES_INSTALL"
