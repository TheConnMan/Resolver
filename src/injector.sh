#!/bin/bash
# HTML injection for server-less applications
# brian@theconnman.com

prog="./injector.sh"

usage() {
	echo "Usage: $prog [-r root] [-d dist]"
	echo "       $prog -h for help."
}

showhelp() {
	echo "Usage: $prog: [-r root] [-d dist]"
	echo "Injector: HTML injection for server-less applications"
	echo "  -r: root HTML directory to be crawled recursively"
	echo "  -d: distribution directory"
	echo "  -h: this help message"
}

root=.
dist=./dist

while getopts "r:d:h" name; do
	case $name in
		r)  root=$OPTARG;;
		d)  dist=$OPTARG;;
		h)  showhelp $0;;
		[?])  usage $0;;
	esac
done

mkdir -p $dist