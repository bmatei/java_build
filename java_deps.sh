#!/bin/bash

####################################################################
####################################################################
######## Generate make style dependency list for java files ########
####################################################################
####################################################################

# Parse the command line
if [ $# -gt 0 ]
then
	DIRS="$@"
else
	DIRS=.
fi

# For every dirrectory passed
for j in $DIRS
do
	if [ ! -d $j ]
	then
		echo "[WARN] $j is not a directory" >&2
		continue
	fi
	B=$(java_packs.sh "$j")
	PACKS="$(echo "$B" | sed -e 's/\. //' -e 's@/@.@g' -e 's/ /|/g')"
	for i in $(find "$j" -regex ".*\.java$")
	do
		A=$(cat $i | grep "^import" | grep -E "$PACKS" | grep -F -v "*")
		a="$?"
#		echo "$A"
#		B="$(
		if [ $a -eq 0 ]
		then
			echo -n "$i: " |\
			 sed -e 's/^\.\///' \
			     -e 's/java/class/'
			echo "$A" |\
			 sed -e 's/import //' \
			     -e 's@\.@/@g' \
			     -e 's/;$//' \
			     -e 's/.*/&.class/' |\
			 tr '\n' ' ' |\
			 awk '{print}'
		fi # )"
#		echo "B='$B'"
#		echo "$B"
	done

done
