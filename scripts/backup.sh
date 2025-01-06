#!/bin/bash

DOTFILES="$HOME/dotfiles"

# Backup current configurations
cp "$HOME/.config/alacritty/alacritty.yml" "$DOTFILES/alacritty/"
cp "$HOME/.tmux.conf" "$DOTFILES/tmux/tmux.conf"
cp "$HOME/.gitconfig" "$DOTFILES/git/gitconfig"
cp "$HOME/.zshrc" "$DOTFILES/zsh/zshrc"
cp "$HOME/.p10k.zsh" "$DOTFILES/zsh/p10k.zsh"

# Git operations
cd "$DOTFILES"
git add .
git commit -m "Backup dotfiles - $(date '+%Y-%m-%d %H:%M:%S')"

# Push if remote exists
if git remote | grep -q "origin"; then
    git push origin main
else
    echo "No remote repository configured. Push manually when ready."
fi
