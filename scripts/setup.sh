#!/bin/bash

DOTFILES="$HOME/dotfiles"

# Function to detect OS
get_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo $ID
    elif [ -f /etc/debian_version ]; then
        echo "debian"
    elif [ -f /etc/redhat-release ]; then
        echo "redhat"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

# Function to install fonts based on OS
install_fonts() {
    local OS=$(get_os)
    echo "Installing fonts for $OS..."
    
    case $OS in
        "ubuntu"|"debian")
            # Create fonts directory if it doesn't exist
            mkdir -p ~/.local/share/fonts
            
            # Download and install JetBrains Mono Nerd Font
            local temp_dir=$(mktemp -d)
            wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip -P "$temp_dir"
            unzip "$temp_dir/JetBrainsMono.zip" -d ~/.local/share/fonts/
            rm -rf "$temp_dir"
            
            # Update font cache
            fc-cache -fv
            ;;
        "macos")
            # Install fonts using Homebrew
            brew tap homebrew/cask-fonts
            brew install --cask font-jetbrains-mono-nerd-font
            ;;
        *)
            echo "Unsupported OS for automatic font installation"
            echo "Please install JetBrains Mono Nerd Font manually"
            ;;
    esac
}

# Function to create symbolic link
create_link() {
    local source=$1
    local target=$2
    
    if [ -f "$source" ]; then
        ln -sf "$source" "$target"
        echo "Linked: $source → $target"
    else
        echo "Warning: Source file $source does not exist"
    fi
}

# Create necessary directories
mkdir -p "$HOME/.config/alacritty"
mkdir -p "$HOME/.tmux/plugins"
mkdir -p "$HOME/.vim/"{backup,swap,undo}

# Install required fonts
install_fonts

# Create symbolic links
create_link "$DOTFILES/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
create_link "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"
create_link "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"
create_link "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
create_link "$DOTFILES/vim/vimrc" "$HOME/.vimrc"

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

echo "Setup complete! Please restart your terminal."










































