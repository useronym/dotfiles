export TERM='xterm-256color'
export XDG_CONFIG_HOME="$HOME/.config"
export BROWSER='chromium'
export EDITOR='vim'

eval "$(thefuck --alias)"

alias e='env TERM=xterm-256color emacs -nw'
alias ls='ls --color'
alias lfe='lfetool'

export ERL_LIBS=~/bin/erl_libs

