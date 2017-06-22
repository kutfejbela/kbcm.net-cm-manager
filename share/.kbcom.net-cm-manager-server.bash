#!/bin/bash

collect_dir_list_configfiles()
# List all config files that needed for host
# stdin: -
# stdout: config file list array
# parameters: host management_config_folder suffix
# return: -
{
 if [ -z "$3" ]
 then
  /bin/echo "ERROR"
  /bin/echo "usage: $0 host management_config_folder suffix."
  exit 1
 fi

 local LOCAL_HOST
 local LOCAL_FOLDER_CONFIG
 local LOCAL_SUFFIX
 local LOCAL_SOURCES
 local LOCAL_FOLDER_CONFIG_COMMONS
 local LOCAL_FOLDER_CONFIG_CONDITION
 local LOCAL_FOLDER_CONFIG_CONDITIONS
 local LOCAL_FOLDER_CONFIG_NODE

 LOCAL_HOST="$1"
 LOCAL_FOLDER_CONFIG_BASE="$2"
 LOCAL_SUFFIX="$3"

 LOCAL_FOLDER_CONFIG_COMMONS="$LOCAL_FOLDER_CONFIG_BASE/common-configuration"
 LOCAL_FOLDER_CONFIG_CONDITION="$LOCAL_FOLDER_CONFIG_BASE/conditions/$LOCAL_HOST.condition"
 LOCAL_FOLDER_CONFIG_CONDITIONS="$LOCAL_FOLDER_CONFIG_BASE/common-configuration"
 LOCAL_FOLDER_CONFIG_NODE="$LOCAL_FOLDER_CONFIG_BASE/nodes/$LOCAL_HOST.$LOCAL_SUFFIX"

 if [ ! -d "$LOCAL_FOLDER_CONFIG_COMMONS" ]
 then
  /bin/echo "ERROR"
  /bin/echo "$LOCAL_FOLDER_CONFIG_COMMONS folder does not exists"
  exit 2
 fi

 LOCAL_SOURCES=$(/usr/bin/find $LOCAL_FOLDER_CONFIG_COMMONS -name "*.$LOCAL_SUFFIX")

 if [ -f "$LOCAL_FOLDER_CONFIG_CONDITION" ]
 then
  LOCAL_SOURCES+=" "`/bin/sed -e "s|.*|$LOCAL_FOLDER_CONFIG_CONDITIONS/&.$LOCAL_SUFFIX|" "$LOCAL_FOLDER_CONFIG_CONDITION"`
 fi

 if [ -f "$LOCAL_FOLDER_CONFIG_NODE" ]
 then
  LOCAL_SOURCES+=" $LOCAL_FOLDER_CONFIG_NODE"
 fi

 echo "$LOCAL_SOURCES"
}

collect_configfiles_list_entries()
# List all entries from config files
# stdin: -
# stdout: entries list array
# parameters: config_files entry_string
# return: -
{
 if [ -z "$2" ]
 then
  echo "ERROR" >&2
  echo "usage: $0 config_files entry_string." >&2
  exit 1
 fi

 local LOCAL_CONFIG_FILES
 local LOCAL_ENTRY_STRING
 local LOCAL_ENTRIES

 LOCAL_CONFIG_FILES="$1"
 LOCAL_ENTRY_STRING="$2"

IFS='
'

 LOCAL_ENTRIES=`/bin/grep -s -h "^$LOCAL_ENTRY_STRING  [^[:blank:]].*$" $LOCAL_CONFIG_FILES | /usr/bin/cut -f 3 -d ' ' | /usr/bin/sort`

 /bin/echo "$LOCAL_ENTRIES"
}

collect_list_list_sameentries()
# List same entries from two list
# stdin: -
# stdout: same entries list array
# parameters: array1 array2
# return: -
{
 if [ -z "$2" ]
 then
  echo "ERROR"
  echo "usage: $0 array array."
  exit 1
 fi

 local LOCAL_ARRAY1
 local LOCAL_ARRAY2
 local LOCAL_SAME_ENTRIES

 LOCAL_ARRAY1="$1"
 LOCAL_ARRAY2="$2"

 IFS=""
 LOCAL_SAME_ENTRIES=`/usr/bin/comm -12 <(echo "${LOCAL_ARRAY1[*]}") <(/bin/echo "${LOCAL_ARRAY2[*]}" | /usr/bin/cut -f 2 -d ' ' | /usr/bin/sort)`

 echo "$LOCAL_SAME_ENTRIES"
}

collect_configfiles_list_fullentries()
# List same entries from two list
# stdin: -
# stdout: entries list array
# parameters: config_files prefix_sting1 prefix_string2 entry_list
# return: -
{
 if [ -z "$3" ]
 then
  echo "ERROR"
  echo "usage: $0 config_files prefix_string entries."
  exit 1
 fi

 local LOCAL_CONFIG_FILES
 local LOCAL_STRING_PREFIX
 local LOCAL_LIST_ENTRIES
 local LOCAL_GREP
 local LOCAL_ENTRIES

 LOCAL_CONFIG_FILES="$1"
 LOCAL_STRING_PREFIX1="$2"
 LOCAL_LIST_ENTRIES="$3"

 LOCAL_GREP=`/usr/bin/printf "$LOCAL_LIST_ENTRIES" | /usr/bin/tr "\n" "|"`

 /bin/grep -s -E "^$LOCAL_STRING_PREFIX  ($LOCAL_GREP)$" $LOCAL_CONFIG_FILES
}
