#!/bin/bash

latesturl="https://github.com/GooseMod/OpenAsar/releases/latest/download/app.asar"

paths=(
  "/usr/share/discord/resources/app.asar"
  "/opt/discord/resources/app.asar"
  "/usr/lib/discord/resources/app.asar"
  "/usr/lib64/discord/resources/app.asar"
  "/var/lib/flatpak/app/com.discordapp.Discord/current/active/files/discord/resources/app.asar"
  "$HOME/.local/share/flatpak/app/com.discordapp.Discord/current/active/files/discord/resources/app.asar"
)

# =======

echo "OpenAsar Installer"

found=false

# discord killing process
if pgrep -x "Discord" >/dev/null; then
  echo "Killing Discord..."
  killall Discord
  echo "Done."
fi

# main replacement
for path in "${paths[@]}"; do
  if [ -f "$path" ]; then
    found=true
    echo "Discord asar found."
    echo "Replacing with patched file..."
    if curl -o "$path" "$latesturl"; then
      echo "Successful. Exiting..."
      nohup Discord
      exit 0
    else
      echo "Failure downloading, check your internet connection."
      exit 1
    fi
  fi
done

if [ "$found" != true ]; then
  echo "app.asar was not found, exiting..."
  exit 1
fi