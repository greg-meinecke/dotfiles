#!/bin/bash

# Run all commands from dotfiles.
cd "$(dirname "$0")"

# Use absolute paths.
DOTFILES_ROOT="$(pwd)"

# Make bash finicky.
set -e

source "$DOTFILES_ROOT/lib/logging.sh"

link () {
    declare src="$1" dest="$2"
    if [ -e "$dest" ]; then
        if [ -h "$dest" ]; then
            # Kill any existing links.
            rm "$dest"
        else
            failure "$dest already exists and is not a link. Clean it up!"
        fi
    fi
    ln -s "$src" "$dest"
    success "Linked $src to $dest."
}

main () {
    # Check for Homebrew, install if we don't have it
    if test ! $(which brew); then
        echo "Installing homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo >> /Users/greggers/.zprofile
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/greggers/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        exec $SHELL
    fi
    
    
    brew update
    
    brew bundle --file $DOTFILES_ROOT/Brewfile

    info "Boostrapping Zsh."
    if [[ $SHELL == "/bin/zsh" ]]; then
        success "zsh is available."
    else
        failure "Zsh is not your shell. Set with 'chsh -s /bin/zsh'."
    fi
    local omz="$HOME/.oh-my-zsh"
    if [ -d "$omz" ]; then
        success "Oh My Zsh is available."
    else
        git clone --depth=1 --quiet \
            https://github.com/robbyrussell/oh-my-zsh.git "$omz"
        success "Fetched Oh My Zsh."
    fi

    info "Make Zee Deerectories!"
    local pip="$HOME/.pip"
    if [ -d "$pip" ]; then
        success "$pip exists."
    else
        mkdir -p "$pip"
        success "Created $pip."
    fi

    info "Symlink ALL THE THINGS!"
    link "$DOTFILES_ROOT/.gitconfig" "$HOME/.gitconfig"
    link "$DOTFILES_ROOT/pip.conf" "$HOME/.pip/pip.conf"
    #link "$DOTFILES_ROOT/zsh/zshenv" "$HOME/.zshenv"
    link "$DOTFILES_ROOT/.zshrc" "$HOME/.zshrc"
    link "$DOTFILES_ROOT/.wezterm.lua" "$HOME/.wezterm.lua"
    link "$DOTFILES_ROOT/.tmux.conf" "$HOME/.tmux.conf"
    link "$DOTFILES_ROOT/.p10k.zsh" "$HOME/.p10k.zsh"
    link "$DOTFILES_ROOT/.vimrc" "$HOME/.vimrc"


    success "You're golden!"
}

main





### macos stuff ###
# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
