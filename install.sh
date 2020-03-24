#!/bin/zsh

# This is the install script
DOTFILES=$HOME/.dotfiles
CONFIG=$HOME/.config
LOCAL_SHARE=$HOME/.local/share
LOCAL_BIN=$HOME/.local/bin
DIRCOLORS=$HOME/.dir_colors
DIRCOLORSHOME=$LOCAL_SHARE/nord_dir_colors
DIFFSOFANCY=$LOCAL_SHARE/diff-so-fancy

echo
if [[ $(which figlet &> /dev/null) ]]; then
    figlet -n ".dotfiles"
else
    echo ".dotfiles"
fi
echo

if [[ ! $(which zsh) ]]; then
    echo "  -> ZSH not found. Please install ZSH."
    echo
    exit 1
fi

echo "First, let's update the system"
sudo dnf update --assumeyes --quiet

echo "Enabling repos for alacritty and fira code fonts"
sudo dnf --assumeyes copr enable agriffis/neovim-nightly
sudo dnf --assumeyes copr enable pschyska/alacritty 
sudo dnf --assumeyes copr enable evana/fira-code-fonts

# Install basic tools
echo "Installing essential programs..."
sudo dnf install --assumeyes \
    git git-extras alacritty tmux neovim \
    fzf fira-code-fonts fontawesome-fonts \
    fd-find bat exa jq

echo "Installing python dependencies"
python3 -m pip install --quiet --user pipx jedi pynvim virtualenv virtualenvwrapper

echo "Installing command line applications"
for PACKAGE in black docformatter ipython pycodestyle poetry; do
    pipx install $PACKAGE
done

# installing cargo
echo "installing cargo"
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly --profile complete
export PATH="$HOME/.cargo/bin:$PATH"

[[ ! -d $CONFIG ]] && mkdir -p $CONFIG
[[ ! -d $LOCAL_SHARE ]] && mkdir -p $LOCAL_SHARE
[[ ! -d $LOCAL_BIN ]] && mkdir -p $LOCAL_BIN

echo
echo "Downloading plugin managers"

# Install plugin managers for ZSH, noevim and tmux
if [[ ! -d $HOME/.oh_my_zsh ]]; then
    echo -n "  Installing Oh My Zsh!..."
    git clone -q https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh_my_zsh
    echo " done"

    ZSH_CUSTOM=$HOME/.oh_my_zsh/custom

    if [[ ! -d $ZSH_CUSTOM/themes/powerlevel10k/ ]]; then
        echo -n "  Installing powerlevel10k..."
        git clone -q https://github.com/romkatv/powerlevel10k.git\
            $HOME/.oh_my_zsh/custom/themes/powerlevel10k
        echo " done"
    fi

    if [[ ! -d $ZSH_CUSTOM/plugins/fast-syntax-highlighting/ ]]; then
        echo -n "  Installing fast-syntax-highlighting..."
        git clone -q https://github.com/zdharma/fast-syntax-highlighting.git\
            $HOME/.oh_my_zsh/custom/plugins/fast-syntax-highlighting
        echo " done"
    fi

    if [[ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions/ ]]; then
        echo -n "  Installing zsh-autosuggestions..."
        git clone -q https://github.com/zsh-users/zsh-autosuggestions.git\
            $HOME/.oh_my_zsh/custom/plugins/zsh-autosuggestions
        echo " done"
    fi
fi

if [[ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ]]; then
    echo -n "  Installing vim.plug Plugin Manager for vim..."
    curl -sfLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo " done"
fi

if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
    echo -n "  Installing TPM plugin manager for Tmux..."
    git clone -q https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    echo " done"
fi

echo
echo "Installing additional stuff"
if [[ ! -d $DIRCOLORSHOME ]]; then
        echo -n "  Downloading nord dir_colors..."
        git clone -q https://github.com/arcticicestudio/nord-dircolors $DIRCOLORSHOME
        [[ ! -f $DIRCOLORS ]] && ln -sf $DIRCOLORSHOME/src/dir_colors $DIRCOLORS
        echo " done"
fi

# Diff-so-fancy
if [[ ! -d $DIFFSOFANCY ]]; then
    echo -n "  Installing diff-so-fancy..."
    git clone -q https://github.com/so-fancy/diff-so-fancy $DIFFSOFANCY
    ln -sf $LOCAL_SHARE/diff-so-fancy/diff-so-fancy $LOCAL_BIN/diff-so-fancy
    echo " done"
fi

# Link all the things
echo
echo "Copying configuration files..."

# Zsh config file
ln -sf $DOTFILES/oh_my_zshrc $HOME/.zshrc

# Git config
GITCONFIG=$HOME/.gitconfig
GITIGNORE=$HOME/.gitignore
[[ ! -f $GITCONFIG ]] && ln -sf $DOTFILES/gitconfig $GITCONFIG
[[ ! -f $GITIGNORE ]] && ln -sf $DOTFILES/gitignore $GITIGNORE

# Noevim
NVIMCONFIG=$CONFIG/nvim
[[ ! -d $NVIMCONFIG ]] && mkdir -p $NVIMCONFIG
[[ ! -f $NVIMCONFIG/init.vim ]] && ln -sf $DOTFILES/nvim/init.vim $NVIMCONFIG/init.vim

# Termite
ALACRITTYCONF=$CONFIG/alacritty
[[ ! -d $KITTYCONFIG ]] && mkdir -p $ALACRITTYCONF
[[ ! -f $KITTYCONFIG/config ]] && ln -sf $DOTFILES/alacritty/alacritty.yml $ALACRITTYCONF/alacritty.yml

# Tmux
TMUXCONFIG=$HOME/.tmux.conf
[[ ! -f $TMUXCONFIG ]] && ln -sf $DOTFILES/tmux/tmux.conf $TMUXCONFIG

# Virtualenv
VIRTUALENVHOME=$HOME/.virtualenv
[[ ! -d $VIRTUALENVHOME ]] && mkdir -p $VIRTUALENVHOME

# Flake8 and black
FLAKE8CONFIG=$CONFIG/flake8
FLAKE8BLACKCONFIG=$CONFIG/flake8-black
ISORTCONFIG=$HOME/.isort.cfg
[[ ! -f $FLAKE8CONFIG ]] && ln -sf $DOTFILES/python/flake8 $FLAKE8CONFIG
[[ ! -f $ISORTCONFIG ]] && ln -sf $DOTFILES/python/isort.cfg $ISORTCONFIG
[[ ! -d $FLAKE8BLACKCONFIG ]] && mkdir -p $FLAKE8BLACKCONFIG
[[ ! -f $FLAKE8BLACKCONFIG/pyproject.toml ]] && ln -sf $DOTFILES/python/blak-config.toml $FLAKE8BLACKCONFIG/pyproject.toml

echo
echo "Installation done, please restart the terminal!"
echo