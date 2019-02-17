export PATH="$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export BROWSER='chromium'
export EDITOR='vim'
export KEYTIMEOUT=1

alias v='vim'
alias e='emacs -nw'
alias ls='ls --color'
alias wtr="curl -q 'http://wttr.in/stary smokovec'"
alias ls="exa --long --header --git"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
