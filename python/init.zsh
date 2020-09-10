# Python configs

export PYTHON_LINE_LENGTH=120
export TEXT_LINE_LENGTH=88

# Debugging python
export PYTHONBREAKPOINT=ipdb.set_trace

# IPython debugger
export PYTHONSTARTUP=$DOTFILES/python/virtualenvwrapper/pythonstartup.py
export PYTHONDONTWRITEBYTECODE=1

# PYthon related functions
pyclean ()
{
    find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
}

# Python aliases
alias p='ipython3'
alias black='black --config $DOTFILES/python/black-config.toml'
alias isort='isort --jobs 4'
alias mypy='mypy --config-file $DOTFILES/python/mypy.ini'

# Poetry aliases. To be overwritten when in a virtualenv
alias pd='poetry run pytest --color yes --durations=10 -lvxs'
alias pa='clear; poetry run pytest --color yes --durations=10 --forked -nauto -qk ""'
alias pc='pa --cov ${PWD##*/} --cov-report term-missing'
alias pdj='pa --cov --cov-report term-missing'
alias pdjc='pdj --cov-report html'

# Poetry aliases for django commands
alias djm='poetry run ./manage.py'

[[ -f $DOTFILES/python/virtualenv.zsh ]] && source $DOTFILES/python/virtualenv.zsh
