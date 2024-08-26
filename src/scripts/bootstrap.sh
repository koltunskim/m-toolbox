#!/bin/bash

export DEBIAN_FRONTEND='noninteractive'

script_dir=$(dirname $(readlink --canonicalize "$0"))
all_scripts=$(find "${script_dir}" -name "*.sh" -not -name "bootstrap.sh")

for script in "${all_scripts}"; do 
	/bin/bash -c "${script}"
done
