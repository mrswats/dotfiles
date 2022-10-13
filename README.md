# DOTFILES

Configuration files as well as installation scrip for dependencies.

## Installation

TODO: This installer works for the linux installation. The Mac OS installation
is not yet available.

To install the dotfiles and all the dependencies run the following commands:

```bash
DOTFILES="$HOME/.config/dotfiles"
git clone https://gitlab.com/mrswats/dotfiles.git $DOTFILES
python -m venv ~/.local/share/venv
~/.local/share/venv/bin/pip install pipx
~/.local/share/venv/bin/pipx install dotbot
~/.local/bin/dotbot -c ./bootstrap/install.conf.yaml
```

## pre-commit

Run

```
pre-commit install
```

to install pre-commit hooks
