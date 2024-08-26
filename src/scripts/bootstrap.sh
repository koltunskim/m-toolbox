#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink --canonicalize "$0"))

all_scripts=$(find "$SCRIPT_DIR" -name "*.sh" -not -name "bootstrap.sh")
ls -al /tmp/scripts

for script in "${all_scripts}"; do 
	/bin/bash -c "${script}"
done


