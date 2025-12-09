HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob notify
bindkey -e

zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

PS1='%B%2F%n%f%b %B%4F%m%f%b%6F[%~]%f%(?.%2F.%1F)%(!.#.$)%f '

export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim +Man!'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
