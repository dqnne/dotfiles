# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim +Man!"

export HISTSIZE=1000
export HISTCONTROL=ignoreboth

function nonzero_return() {
    RETVAL=$?
    [ $RETVAL -ne 0 ] && echo "[$RETVAL] "
}

export PS1="\[\e[32m\]\w\[\e[m\] \[\e[31m\]\`nonzero_return\`\[\e[m\]\\$ "
export PROMPT_DIRTRIM=2
