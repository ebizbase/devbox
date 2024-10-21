#!/bin/sh
set -e

# Run all shell scripts in /etc/entrypoint.d/
if [ -d "/etc/entrypoint/init.d" ]; then
  for script in /etc/entrypoint/init.d/*.sh; do
    if [ -f "$script" ]; then
      echo "Running $script"
      . "$script"
    fi
  done
fi

# Execute the command passed to the entrypoint
exec "$@"