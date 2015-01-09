#!/bin/bash

STEAMROOT="$(cd "${0%/*}" && echo $PWD)"
STEAMEXE=`basename "$0" .sh`

PLATFORM=linux32 # dedicated server build (minimal dependencies)

# prepend our lib path to LD_LIBRARY_PATH
export LD_LIBRARY_PATH="$STEAMROOT/$PLATFORM:$LD_LIBRARY_PATH"

ulimit -n 2048

MAGIC_RESTART_EXITCODE=42

# and launch steam
if [ "$DEBUGGER" == "gdb" ] || [ "$DEBUGGER" == "cgdb" ]; then
	ARGSFILE=$(mktemp $USER.steam.gdb.XXXX)

	# Set the LD_PRELOAD varname in the debugger, and unset the global version. 
	if [ "$LD_PRELOAD" ]; then
		echo set env LD_PRELOAD=$LD_PRELOAD >> "$ARGSFILE"
		echo show env LD_PRELOAD >> "$ARGSFILE"
		unset LD_PRELOAD
	fi

	$DEBUGGER -x "$ARGSFILE" "$STEAMROOT/$PLATFORM/$STEAMEXE" "$@"
	rm "$ARGSFILE"
else
	$DEBUGGER "$STEAMROOT/$PLATFORM/$STEAMEXE" "$@"
fi
STATUS=$?

if [ $STATUS -eq $MAGIC_RESTART_EXITCODE ]; then
    exec "$0" "$@"
fi
exit $STATUS
