#!/bin/bash

# In case we set host instead of srvname replace -H with -S
options=$( echo $@ | sed -e 's/-H /-S /' -e 's/ -i.*//' )
# get rid of the file flag because it's not supported??
sql_scratch=$( echo $@ | sed 's|^.* -i||' )
# now execute the command
cat $sql_scratch | tsql $options

