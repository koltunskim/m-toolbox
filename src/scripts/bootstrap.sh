#!/bin/bash

export DEBIAN_FRONTEND='noninteractive'

script_dir=$(dirname $(readlink --canonicalize "$0"))
all_scripts=$(find "${script_dir}" -name "*.sh" -not -name "bootstrap.sh" | sort)

for script in "${all_scripts}"; do 
	echo "scripts to run: "${all_scripts}"
	echo "now running: "${script}"
	/bin/bash -c "${script}"
done
