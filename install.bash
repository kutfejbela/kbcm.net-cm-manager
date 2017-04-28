# /etc
/bin/mkdir -p "/etc/kbnet.com-cm/manager-server"

# /usr/lib/cgi-bin
/bin/mkdir -p "/usr/lib/cgi-bin/kbcom.net-cm"
/bin/ln -s "$PWD/cgi-bin" "/usr/lib/cgi-bin/kbcom.net-cm/manager-server"

# /usr/share
/bin/mkdir -p "/usr/share/kbcom.net-cm"
/bin/ln -s "$PWD/share" "/usr/share/kbcom.net-cm/manager-server"
