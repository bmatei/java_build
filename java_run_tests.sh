#!/bin/bash

if [ $# -eq 0 ]
then
	DIRS=.
else
	DIRS="$@"
fi

E_CODE=0
FLIST=""
for i in $DIRS
do
	for t in $(find $i -regex ".*\.java" |\
	 sed -e 's/\.java$//' \
	     -e 's@^\./@@' \
	     -e 's@/@.@g')
	do
		f="$(echo $t | sed 's@\.@/@g').java"
		if grep -q "extends .*UnitTest" $f
		then
			echo "Running tests for $t:"
			java matei.utils.RunUnitTests $t
			if [ $? -eq 1 ]
			then
				FLIST="$FLIST $t"
				E_CODE=1
			fi
			echo "==========================="
		fi
	done

done
if [ $E_CODE -eq 1 ]
then
	echo "Failed:$FLIST"
else
	echo "Success"
fi
exit $E_CODE
