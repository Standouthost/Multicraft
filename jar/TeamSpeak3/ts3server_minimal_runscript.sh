#!/bin/sh

export LD_LIBRARY_PATH=".:$LD_LIBRARY_PATH"

D1=$(readlink -f "$0")
D2=$(dirname "${D1}")
cd "${D2}"

if [ -e ts3server_linux_x86 ]; then
	if [ -z "`uname | grep Linux`" -o ! -z "`uname -m | grep 64`" ]; then
		echo "Do you have the right TS3 Server package for your system? You have: `uname` `uname -m`, not Linux i386."
	fi
	./ts3server_linux_x86 $@
elif [ -e ts3server_linux_amd64 ]; then
	if [ -z "`uname | grep Linux`" -o -z "`uname -m | grep 64`" ]; then
		echo "Do you have the right TS3 Server package for your system? You have: `uname` `uname -m`, not Linux x86_64."
	fi
	./ts3server_linux_amd64 $@
elif [ -e ts3server_freebsd_x86 ]; then
	if [ ! -z "`uname | grep Linux`" -o ! -z "`uname -m | grep 64`" ]; then
		echo "Do you have the right TS3 Server package for your system? You have: `uname` `uname -m`, not FreeBSD i386."
	fi
	./ts3server_freebsd_x86 $@
elif [ -e ts3server_freebsd_amd64 ]; then
	if [ ! -z "`uname | grep Linux`" -o -z "`uname -m | grep 64`" ]; then
		echo "Do you have the right TS3 Server package for your system? You have: `uname` `uname -m`, not FreeBSD amd64."
	fi
	./ts3server_freebsd_amd64 $@
else
	echo 'Could not find binary, aborting'
fi


