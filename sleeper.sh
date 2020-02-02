#!/usr/bin/env bash

set -eu

# run for 30mins before ending
runtime=${RUNTIME:-1800}

echo "will run for $runtime seconds, before exiting container"
echo "-- you can override this by passing RUNTIME=33 to the container"

sleep $runtime
