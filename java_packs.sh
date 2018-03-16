#!/bin/bash

##########################################################################
##########################################################################
########## Generate a list of the possible packets in a directory ########
##########################################################################
##########################################################################

# Important variables
E_SUCCES=0
E_BAD_CMD_LINE=1

# Parse the command line
if [ $# -ne 1 ]
then
	echo "Usage: $0 <directory>" >&2
	exit $E_BAD_CMD_LINE
else
	DIR="$1"
fi

B=""
for i in $(find $DIR -type d)
do
	A=$(find $i -maxdepth 1 -regex ".*\.java$")
	if [ ! -z "$A" ]
	then
		B="$B $i"
	fi
done
echo "$B" | sed -e 's@\./@@g' -e 's/^  *//'
exit $E_SUCCES