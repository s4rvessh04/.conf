#!/bin/bash

get_os_name() {
    uname -s
}

check_os() {
    os_name=$(get_os_name)

    if [ "$os_name" == "Linux" ] || [ "$os_name" == "Darwin" ]; then
        echo "OS is good to go!"
    else
        echo "Script intended for pro users only LOL."
        exit 1
    fi
}

check_software_exists() {
    if ! command -v $1 &> /dev/null; then
        echo "$1 not found! Install to continue."

    else
        echo "$1 is already installed."
    fi
}

download_dotfiles() {
    repo_url="https://github.com/s4rvessh04/.conf.git"

    echo "Downloading dotfiles from $repo_url..."
    git clone "$repo_url" "$HOME/.conf"
}

handle_software_configs() {
    case $1 in
        "git")
            check_software_exists git
            
            echo "Setting up git..."
            
            read -p "Enter your git username: " git_username
            git config --global user.name "$git_username"

            read -p "Enter your git email: " git_email
            git config --global user.email "$git_email"
        ;;
        ".bashrc")
            echo "Setting up bash..."

            mv -f "$HOME/.conf/.bashrc" "$HOME"
        ;;
        ".zshrc")
            check_software_exists zsh

            echo "Setting up zshrc..."

            mv -f "$HOME/.conf/.zshrc" "$HOME"
        ;;
        ".tmux.conf")
            check_software_exists tmux

            echo "Setting up tmux..."

            mv -f "$HOME/.conf/.tmux.conf" "$HOME"
        ;;
        "alacritty")
            check_software_exists alacritty

            echo "Setting up alacritty..."

            if ! [ -d "$HOME/.config/alacritty" ]; then
                mkdir -p "$HOME/.config/alacritty"
            fi
            mv -f "$HOME/.conf/alacritty.yml" "$HOME/.config/alacritty/"
        ;;
        "mpv")
            check_software_exists mpv

            echo "Setting up mpv..."
            
            if ! [ -d "$HOME/.config/mpv" ]; then
                mkdir -p "$HOME/.config/mpv"
            fi
            mv -f "$HOME/.conf/mpv.conf" "$HOME/.config/mpv/"
        ;;
        "nvim")
            check_software_exists nvim

            echo "Setting up nvim..."

            if ! [ -d "$HOME/.config/nvim" ]; then
                mkdir -p "$HOME/.config/nvim"
            fi
            mv "$HOME/.conf/nvim" "$HOME/.config/nvim/"
        ;;
    *)
            echo "No software config found for $1."
    esac

}



setup() {
    echo "Setting up your machine..."

    check_os
    download_dotfiles
    handle_software_configs git
}

setup