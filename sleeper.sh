#!/usr/bin/env bash

set -eu

echo "Container running continuously - ready for cluster utilities work"
echo "Use kubectl exec to connect and run commands interactively"
echo "Container will keep running until manually stopped"

# Keep container running indefinitely
# Using tail -f /dev/null is a common pattern for keeping containers alive
tail -f /dev/null
