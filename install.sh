# !/bin/bash

DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"

configs=(
  sway
  foot
  waybar
  fuzzel
  nvim
  mako
)

for cfg in "${configs[@]}"; do
  src="$DOTFILES/$cfg"
  dst="$CONFIG/$cfg"

  if [ ! -d "$src" ]; then
    echo "skipping $cfg (not found in dotfiles)"
    continue
  fi

  if [ -L "$dst" ]; then
    echo "already linked: $cfg"
  elif [ -d "$dst" ]; then
    echo "backing up existing $cfg -> $cfg.bak"
    mv "$dst" "$dst.bak"
    ln -s "$src" "$dst"
    echo "linked: $cfg"
  else
    ln -s "$src" "$dst"
    echo "linked: $cfg"
  fi
done

echo "done"
