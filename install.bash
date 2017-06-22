#!/bin/bash

# /etc
/bin/mkdir -p "/etc/kbcom.net-cm/manager-server"

# /usr/lib/cgi-bin
if [ ! -e "/usr/lib/cgi-bin/kbcom.net-cm/manager-server" ]
then
 /bin/mkdir -p "/usr/lib/cgi-bin/kbcom.net-cm"
 /bin/ln -s "$PWD/cgi-bin" "/usr/lib/cgi-bin/kbcom.net-cm/manager-server"
else
 /bin/echo "'/usr/lib/cgi-bin/kbcom.net-cm/manager-server' does exists"
fi

# /usr/share
if [ ! -e "/usr/share/kbcom.net-cm/manager-server" ]
then
 /bin/mkdir -p "/usr/share/kbcom.net-cm"
 /bin/ln -s "$PWD/share" "/usr/share/kbcom.net-cm/manager-server"
else
 /bin/echo "'/usr/share/kbcom.net-cm/manager-server' does exists"
fi
