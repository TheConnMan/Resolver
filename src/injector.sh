#!/bin/bash
# HTML injection for server-less applications
# brian@theconnman.com

prog="./injector.sh"

usage() {
	echo "Usage: $prog [-r root] [-d dist] [-f]"
	echo "       $prog -h for help."
	exit
}

showhelp() {
	echo "Usage: $prog: [-r root] [-d dist] [-f]"
	echo "Injector: HTML injection for server-less applications"
	echo "  -r: root HTML directory to be crawled recursively"
	echo "  -d: distribution directory"
	echo "  -f: force overwrite distribution directory"
	echo "  -h: this help message"
}

# Initialize variables and define defaults

root=.
dist=./dist
force=false

# Get arguments

while getopts "fr:d:h" name; do
	case $name in
		r)  root=$OPTARG;;
		d)  dist=$OPTARG;;
		f)  force=true;;
		h)  showhelp $0;;
		[?])  usage $0;;
	esac
done

# Resolves injections within a single file
resolvefile() {
	local loc=$dist${1#$root}
	
	# Check to see if file has already been resolved
	if [[ ! -f $loc ]]; then
	
		# Create folder and blank file
		mkdir -p $(dirname $loc)
		touch $loc
		echo "Resolving ${1#$root}"
		
		while read line || [[ -n "$line" ]]; do
			if [[ $line == *"<% injector"* ]]; then
			
				# Find injected file location
				local depen=`expr "$line" : '^.*src="\(.*\)".*'`
				
				# Resolve injected file if it hasn't been already
				if [ ! -f $dist$depen ]; then
					resolvefile $root$depen
				fi
				cat $dist$depen >> $loc;
			else
				echo $line >> $loc;
			fi
		done < $1
	fi
}

# Delete distribution directory

if [[ ( -d $dist ) && ( $force == "false" ) ]]; then
	echo "The distribution folder $dist is not empty and will be deleted. Would you like to continue (yes/no)? [no]"
	read choice
	
	if [[ $choice != "yes" ]]; then
		echo "Exiting"
		exit
	fi
fi

rm -rf $dist/*
mkdir -p $dist

# Resolve all files in the source directory
for f in $(find $root -name "*"); do
	if [ -f $f ]; then
		resolvefile $f;
	fi
done