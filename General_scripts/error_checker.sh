#!/bin/bash
if [ "$1" == "" ]; then
#	directory="./"
	echo "Afegeix l'arxiu per fer check.."
else
#	if [[ "$1" =~ ^[0-9]+$ ]] ; then
#		directory="$PROJECTS/BF$1*/*/logs"
#	else
		directory=$1
#	fi

	echo "Checking for errors in $directory..."
	grep -Ri --color " error " $directory
	grep -Ri --color " fatal "  $directory
	grep -Ri --color " fault "  $directory
	grep -Ri --color " warning " $directory
	grep -Ri --color " cancelled " $directory
fi
