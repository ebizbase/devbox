#!/bin/sh
set -e

echo "██████╗ ███████╗██╗   ██╗██████╗  ██████╗ ██╗  ██╗"
echo "██╔══██╗██╔════╝██║   ██║██╔══██╗██╔═══██╗╚██╗██╔╝"
echo "██║  ██║█████╗  ██║   ██║██████╔╝██║   ██║ ╚███╔╝ "
echo "██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══██╗██║   ██║ ██╔██╗ "
echo "██████╔╝███████╗ ╚████╔╝ ██████╔╝╚██████╔╝██╔╝ ██╗"
echo "╚═════╝ ╚══════╝  ╚═══╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═╝"
echo "                                                  "
echo "         Welcome to the DevBox container          "
echo "                                                  "


# Run all shell scripts in /etc/entrypoint.d/
if [ -d "/etc/entrypoint/init.d" ]; then
  for script in /etc/entrypoint/init.d/*.sh; do
    if [ -f "$script" ]; then
      echo "Run init script: $script"
      . "$script" &
    fi
  done
  wait
  echo "All init scripts run"
fi

# Execute the command passed to the entrypoint
exec "$@"