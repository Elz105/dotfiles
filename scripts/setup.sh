#!/bin/bash

DOTFILES="$HOME/dotfiles"

# Create necessary directories
mkdir -p "$HOME/.config/alacritty"
mkdir -p "$HOME/.tmux/plugins"

# Alacritty setup
ln -sf "$DOTFILES/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"

# tmux setup
ln -sf "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"

# Git setup
ln -sf "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"

# ZSH setup
ln -sf "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/zsh/p10k.zsh" "$HOME/.p10k.zsh"

# Vim setup
ln -sf "$DOTFILES/vim/vimrc" "$HOME/.vimrc"

# Create vim directories if they don't exist
mkdir -p "$HOME/.vim/"{backup,swap,undo}

# Install tmux plugin manager if not exists
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install oh-my-zsh if not exists
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install powerlevel10k if not exists
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

echo "Dotfiles setup complete!"
